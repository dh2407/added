import type { SectionResponse } from "../../../../../generated-api/index.ts";
import { ErrorInfo } from "../../_shared/types.ts";

export interface SectionRepository {
    getFirstSection(subjectId: string): Promise<SectionResponse | ErrorInfo>;
    getNextSection(sectionId: string): Promise<SectionResponse | ErrorInfo>;
}