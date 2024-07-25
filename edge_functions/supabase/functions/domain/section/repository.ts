import { SectionResponse } from "../../../../../generated-api/index.ts";

export interface SectionRepository {
    getFirstSection(subjectId: string): Promise<SectionResponse | null>;
    getNextSection(sectionId: string): Promise<SectionResponse | null>;
}