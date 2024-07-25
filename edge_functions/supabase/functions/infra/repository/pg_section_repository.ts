import type { SectionResponse } from "../../../../../generated-api/index.ts";
import { ErrorInfo } from "../../_shared/types.ts";
import { SectionRepository } from "../../domain/section/repository.ts";
import { getPostgresPool } from "./pg_repository.ts";

export class PgSectionRepository implements SectionRepository {
    async getFirstSection(subjectId: string): Promise<SectionResponse | ErrorInfo> {
        try {
            const pool = getPostgresPool();
            const connection = await pool.connect();
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
                    return {
                        error: "[PgSectionRepository.getFirstSection] No row found!",
                        message: "Subject don't have any sections."
                    };
                }

                const responseData: SectionResponse = {
                    kind: row.kind,
                    scenes: row.scenes,
                    section_id: row.id.toString(),
                    is_last: parseInt(row.order) === parseInt(row.total_count)
                };

                return responseData;
            } catch (error) {
                return {
                    error,
                    message: "[PgSectionRepository.getFirstSection] Querying database Error!" 
                };
            } finally {
                connection.release();
            }
        } catch (error) {
            return {
                error,
                message: "[PgSectionRepository.getFirstSection] Database connection Error!" 
            };
        }
    }

    async getNextSection(sectionId: string): Promise<SectionResponse | ErrorInfo> {
        try {
            const pool = getPostgresPool();
            const connection = await pool.connect();
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
                    return {
                        error: "[PgSectionRepository.getNextSection] No row found!",
                        message: "Section don't have any next sections."
                    };
                }

                const responseData: SectionResponse = {
                    kind: row.kind,
                    scenes: row.scenes,
                    section_id: row.id.toString(),
                    is_last: parseInt(row.order) === parseInt(row.total_count)
                };

                return responseData;
            } catch (error) {
                return {
                    error,
                    message: "[PgSectionRepository.getNextSection] Querying database Error!" 
                };
            } finally {
                connection.release();
            }
        } catch (error) {
            return {
                error,
                message: "[PgSectionRepository.getNextSection] Database connection Error!" 
            };
        }
    }
}
