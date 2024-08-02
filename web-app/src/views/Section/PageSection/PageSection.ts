import { PageModel } from '../../../../../generated-api/index'
import { SectionHandler } from '../SectionHandler';

export class PageSection {
    public page: PageModel;

    private _sectionHandler: SectionHandler;

    constructor(sectionHandler: SectionHandler ) {
        this._sectionHandler = sectionHandler;
        this.page = sectionHandler.currentSection.page!;
    }

    public goToSection(sectionId: string) {
        this._sectionHandler.goToSection(sectionId)
    }
}
