import type { SectionResponse } from "../../../../../generated-api/index.ts";

export interface SectionRepository {
    getFirstSection(subjectId: string): Promise<SectionResponse>;
    getNextSection(sectionId: string): Promise<SectionResponse>;
}