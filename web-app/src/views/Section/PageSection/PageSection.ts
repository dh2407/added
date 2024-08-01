import { PageModel } from '../../../../../generated-api/index'

export class PageSection {
    public page: PageModel;

    constructor(page: PageModel ) {
        this.page = page;
    }
}
