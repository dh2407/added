import { Page, SectionResponse } from '../../../../../generated-api/index'

export class PageSection {
    public page: Page;

    constructor(section: SectionResponse) {
        this.page = section.page;
    }
}
