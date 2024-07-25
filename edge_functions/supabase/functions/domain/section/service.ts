import type { SectionResponse } from "../../../../../generated-api/index.ts";
import { ErrorInfo } from "../../_shared/types.ts";
import { SectionRepository } from "./repository.ts";

export class SectionService {
    constructor(private sectionRepository: SectionRepository) {}

    async getFirstSection(subjectId: string): Promise<SectionResponse | ErrorInfo> {
      // WIP: DO WE USE TRY CATCH HERE AND RAISE THE ERROR ON THE REPOSITORY ?
      // WIP:  DO WE ADD HELPERS TO PREPARE THE API RESPONSE FROM HERE ?
      // if (Object.keys(data).includes('error')) console.log('YES')
      // else console.log('NO!')
      return await this.sectionRepository.getFirstSection(subjectId);
    }
  
    async getNextSection(sectionId: string): Promise<SectionResponse | ErrorInfo> {
      return await this.sectionRepository.getNextSection(sectionId);
    }
   
}