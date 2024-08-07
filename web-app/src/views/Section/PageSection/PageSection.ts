import { ActionModel, PageModel } from '#/index'

export class PageSection {
    private _html: string;
    private _backgroundColor?: string;
    private _actions?: ActionModel[];
    private _goToSectionCallback: (sectionId: string, params?: object) => void;

    constructor(page: PageModel, goToSection: (sectionId: string, params?: object) => void, params?: object) {
        this._goToSectionCallback = goToSection;
        this._html = this._resolveHtmlPlaceholders(page.html, params);
        this._backgroundColor = page.background_color;
        this._actions = page.actions;
    }

    public goToSection(sectionId: string, params?: object) {
        this._goToSectionCallback(sectionId, params)
    }

    private _resolveHtmlPlaceholders(html: string, params?: object): string {
        if (params) {
            return Object.entries(params).reduce((updatedHtml, [key, value]) => {
                const escapedKey = key.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
                return updatedHtml.replaceAll(`{{${escapedKey}}}`, value);
            }, html);
        }
        return html;
    }

    get html(): string {
        return this._html
    }

    get backgroundColor(): string | undefined {
        return this._backgroundColor
    }

    get actions(): ActionModel[] | undefined {
        return this._actions
    }
}
