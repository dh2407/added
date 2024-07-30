import type { SectionResponse } from "../../../../../generated-api/index.ts";
import { ErrorInfo } from "../../_shared/types.ts";
import { SectionRepository } from "../../domain/section/repository.ts";
import { getPostgresPool } from "./pg_repository.ts";

export class PgSectionRepository implements SectionRepository {
    async getFirstSection(subjectId: string): Promise<SectionResponse> {
        const pool = getPostgresPool();
        let connection;
        try {
            connection = await pool.connect();
        } catch (error) {
            throw new ErrorInfo(
                `[PgSectionRepository.getFirstSection] Database connection error: ${error.message}`,
                "Unable to connect to the database. Please try again later."
            );
        }

        try {
            const result = await connection.queryObject`
            WITH first_section AS (
                SELECT *, ROW_NUMBER() OVER (ORDER BY "order" ASC) AS rn
                FROM "Section"
                WHERE subject_id = ${subjectId}
                ORDER BY "order" ASC
                LIMIT 1
            ),
            total_count AS (
                SELECT COUNT(*)::int8 AS total_count
                FROM "Section"
                WHERE subject_id = ${subjectId}
            ),
            scenes AS (
                SELECT s.id as section_id, 
                    array_agg(json_build_object(
                        'image_url', i.image_url,
                        'segments', (
                            SELECT array_agg(json_build_object(
                                'text', seg.text,
                                'sound_url', snd.sound_url
                            ))
                            FROM "Segment" seg
                            LEFT JOIN "Sound" snd ON seg.sound_id = snd.id
                            WHERE seg.scene_id = sc.id
                        )
                    )) AS scenes
                FROM "Section" s
                LEFT JOIN "Story" st ON s.id = st.section_id
                LEFT JOIN "Scene" sc ON st.id = sc.story_id
                LEFT JOIN "Image" i ON sc.id = i.scene_id
                WHERE s.subject_id = ${subjectId} AND s.kind = 'STORY'
                GROUP BY s.id
            )
            SELECT fs.*, tc.total_count, CASE WHEN fs.kind = 'STORY' THEN sn.scenes ELSE NULL END AS scenes
            FROM first_section fs
            CROSS JOIN total_count tc
            LEFT JOIN scenes sn ON fs.id = sn.section_id;`;


            const row = result.rows[0];

            if (!row) {
                throw new ErrorInfo(
                    "No row found! Subject doesn't have any sections.",
                    "No sections found for the given subject."
                );
            }

            const responseData: SectionResponse = {
                kind: row.kind,
                scenes: row.scenes,
                section_id: row.id.toString(),
                is_last: parseInt(row.order) === parseInt(row.total_count)
            };

            return responseData;
        } catch (error) {
            throw new ErrorInfo(
                `[PgSectionRepository.getFirstSection] Querying database error: ${error.message}`,
                "Error fetching the first section. Please try again later."
            );
        } finally {
            connection.release();
        }
    }

    async getNextSection(sectionId: string): Promise<SectionResponse> {
        const pool = getPostgresPool();
        let connection;
        try {
            connection = await pool.connect();
        } catch (error) {
            throw new ErrorInfo(
                `[PgSectionRepository.getNextSection] Database connection error: ${error.message}`,
                "Unable to connect to the database. Please try again later."
            );
        }

        try {
            const result = await connection.queryObject`
                WITH current_section AS (
                    SELECT *
                    FROM "Section"
                    WHERE id = ${sectionId}
                ),
                next_section AS (
                    SELECT *, ROW_NUMBER() OVER (ORDER BY "order" ASC) as rn
                    FROM "Section"
                    WHERE subject_id = (SELECT subject_id FROM current_section)
                    AND "order" = (SELECT "order" FROM current_section) + 1
                    LIMIT 1
                ),
                total_count AS (
                    SELECT COUNT(*)::int8 AS total_count
                    FROM "Section"
                    WHERE subject_id = (SELECT subject_id FROM current_section)
                ),
                scenes AS (
                    SELECT s.id as section_id, 
                        array_agg(json_build_object(
                            'image_url', i.image_url,
                            'segments', (
                                SELECT array_agg(json_build_object(
                                    'text', seg.text,
                                    'sound_url', snd.sound_url
                                ))
                                FROM "Segment" seg
                                LEFT JOIN "Sound" snd ON seg.sound_id = snd.id
                                WHERE seg.scene_id = sc.id
                            )
                        )) AS scenes
                    FROM "Section" s
                    LEFT JOIN "Story" st ON s.id = st.section_id
                    LEFT JOIN "Scene" sc ON st.id = sc.story_id
                    LEFT JOIN "Image" i ON sc.id = i.scene_id
                    WHERE s.subject_id = (SELECT subject_id FROM current_section) AND s.kind = 'STORY'
                    GROUP BY s.id
                )
                SELECT ns.*, tc.total_count, CASE WHEN ns.kind = 'STORY' THEN sn.scenes ELSE NULL END AS scenes
                FROM next_section ns
                CROSS JOIN total_count tc
                LEFT JOIN scenes sn ON ns.id = sn.section_id;`;
        
            const row = result.rows[0];

            if (!row) {
                throw new ErrorInfo(
                    "No row found! Section doesn't have any next sections.",
                    "No next section found for the given section."
                );
            }

            const responseData: SectionResponse = {
                kind: row.kind,
                scenes: row.scenes,
                section_id: row.id.toString(),
                is_last: parseInt(row.order) === parseInt(row.total_count)
            };

            return responseData;
        } catch (error) {
            throw new ErrorInfo(
                `[PgSectionRepository.getNextSection] Querying database error: ${error.message}`,
                "Error fetching the next section. Please try again later."
            );
        } finally {
            connection.release();
        }
    }
}