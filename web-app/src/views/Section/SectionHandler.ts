import { QuestionsGameSection } from './QuestionsGameSection/QuestionsGameSection';
import { StorySection } from './StorySection/StorySection';
import { PageSection } from './PageSection/PageSection';
import { SectionResponse } from '../../../../generated-api';


export class SectionHandler {
    public currentSectionInstance: QuestionsGameSection | StorySection | PageSection;
    public currentSection: SectionResponse;

    constructor(section: SectionResponse) {
        this.currentSection = section;
        this.currentSectionInstance = this.createSectionInstance(this.currentSection);
    }

    private createSectionInstance(currentSection: SectionResponse) {
        // TODO HANDLE IF DATA IS NOT CORRECT FROM API (eg: kind is PAGE but there is no page in the data)
        switch (currentSection.kind) {
            case 'QUESTIONS_GAME':
                return new QuestionsGameSection(this.currentSection.questions_game!);
            case 'STORY':
                return new StorySection(this.currentSection);
            case 'PAGE':
                return new PageSection(this.currentSection.page!);
            default:
                throw new Error(`Unknown section type: ${this.currentSection.kind}`);
        }
    }
}
