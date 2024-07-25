import { SectionResponse } from "../../../../../generated-api/index.ts";
import { SectionRepository } from "./repository";

export class SectionService {
    constructor(private sectionRepository: SectionRepository) {}

    async getFirstSection(subjectId: string): Promise<SectionResponse | null> {
      return await this.sectionRepository.getFirstSection(subjectId);
    }
  
    async getNextSection(sectionId: string): Promise<SectionResponse | null> {
      return await this.sectionRepository.getNextSection(sectionId);
    }
   
}