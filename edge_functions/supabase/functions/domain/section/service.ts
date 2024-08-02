import type { SectionResponse } from "../../../../../generated-api/index.ts";
import { SectionRepository } from "./repository.ts";

export class SectionService {
    constructor(private sectionRepository: SectionRepository) {}

    async getFirstSection(subjectId: string): Promise<SectionResponse> {
        try {
            return await this.sectionRepository.getFirstSection(subjectId);
        } catch (error) {
            throw error
        }
    }
  
    async getNextSection(sectionId: string): Promise<SectionResponse> {
        try {
            return await this.sectionRepository.getNextSection(sectionId);
        } catch (error) {
            throw error
        }
    }

    async getSection(sectionId: string): Promise<SectionResponse> {
        try {
            return await this.sectionRepository.getSection(sectionId);
        } catch (error) {
            throw error
        }
    }
}
