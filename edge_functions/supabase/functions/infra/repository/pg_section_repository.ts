import { SectionResponse } from "../../../../../generated-api/index.ts";
import { SectionRepository } from "../../domain/section/repository";
import { getPostgresPool } from "./pg_repository";

export class PgSectionRepository implements SectionRepository {
    async getFirstSection(subjectId: string): Promise<SectionResponse | null> {
        try {
            const pool = getPostgresPool();
            const connection = await pool.connect();
            try {
                const firstSectionResult = await connection.queryObject`
                SELECT * FROM "Section"
                WHERE subject_id = ${subjectId}
                ORDER BY "order" ASC
                LIMIT 1
              `;

                const firstSection = firstSectionResult.rows[0];

                const totalCountResult = await connection.queryObject`
                SELECT COUNT(*)::int8 AS total_count FROM "Section"
                WHERE subject_id = ${subjectId}
              `;

                console.log(totalCountResult, "here")

                const totalCount = Number(totalCountResult.rows[0]?.total_count);
                console.log(totalCount, "totalCount")

                if (!firstSection) {
                    return null
                }

                const responseData: SectionResponse = {
                    kind: firstSection.kind,
                    scenes: firstSection.scenes,
                    section_id: Number(firstSection.id).toString(),
                    is_last: firstSection.order === totalCount
                };

                return responseData
            } catch (error) {
                return null
            } finally {
                connection.release();
            }
        } catch (error) {
            return null
        }
    }

    async getNextSection(sectionId: string): Promise<SectionResponse | null> {
        // DATA BASE COMMUNICATION TO RETURN RAW SECTION 
        return null;
    }
}

