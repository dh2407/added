import { QuestionsGameSection } from './QuestionsGameSection/QuestionsGameSection';
import { StorySection } from './StorySection/StorySection';
import { PageSection } from './PageSection/PageSection';
import { SectionResponse } from '#/index';
import { ApiService } from '@/services';

export class SectionHandler {
    public currentSectionInstance: QuestionsGameSection | StorySection | PageSection;
    public currentSection: SectionResponse;
    public isLoading: boolean;

    constructor(section: SectionResponse) {
        this.currentSection = section;
        this.currentSectionInstance = this.createSectionInstance();
        this.isLoading = false;
    }

    private createSectionInstance(params?: object) {
        switch (this.currentSection.kind) {
            case 'QUESTIONS_GAME':
                return new QuestionsGameSection(this.currentSection.questions_game!, this.goToNextSection.bind(this), params);
            case 'STORY':
                return new StorySection(this);
            case 'PAGE':
                return new PageSection(this.currentSection.page!, this.goToSection.bind(this), params);
            default:
                throw new Error(`Unknown section type: ${this.currentSection.kind}`);
        }
    }

    public async goToNextSection(params?: object) {
        const newSection = await this.fetchNextSection();
        if (newSection) {
            this.currentSection = newSection;
            this.currentSectionInstance = this.createSectionInstance(params);
        } else {
            alert('NO NEXT SECTION')
        }
    }

    public async goToSection(sectionId: string, params?: object) {
        const newSection = await this.fetchSection(sectionId);
        if (newSection) {
            this.currentSection = newSection;
            this.currentSectionInstance = this.createSectionInstance(params);
        }
    }

    private async fetchNextSection() {
        // TODO: Handle Error here and in fetchNextSection function callers
        try {
            this.isLoading = true;
            const { data } = await ApiService.sectionGetNextSectionPost({ section_id: this.currentSection.section_id });
            if (data.error) {
                console.error('Error:', data.error);
                return;
            }
            if (data.data) {
                return data.data;
            }
        } catch (err) {
            console.error('Fetch error:', err);
        } finally {
            this.isLoading = false;
        }
    }

    private async fetchSection(sectionId: string) {
        // TODO: Handle Error here and in sectionGetPost function callers
        try {
            this.isLoading = true;
            const { data } = await ApiService.sectionGetPost({ section_id: sectionId });
            if (data.error) {
                console.error('Error:', data.error);
                return;
            }
            if (data.data) {
                return data.data;
            }
        } catch (err) {
            console.error('Fetch error:', err);
        } finally {
            this.isLoading = false;
        }
    }
}
