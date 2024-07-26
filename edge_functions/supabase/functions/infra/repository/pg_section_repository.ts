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
                    SELECT *, ROW_NUMBER() OVER (ORDER BY "order" ASC) as rn
                    FROM "Section"
                    WHERE subject_id = ${subjectId}
                    ORDER BY "order" ASC
                    LIMIT 1
                ),
                total_count AS (
                    SELECT COUNT(*)::int8 AS total_count
                    FROM "Section"
                    WHERE subject_id = ${subjectId}
                )
                SELECT fs.*, tc.total_count
                FROM first_section fs
                CROSS JOIN total_count tc;
              `;

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
                )
                SELECT ns.*, tc.total_count
                FROM next_section ns
                CROSS JOIN total_count tc;
              `;

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