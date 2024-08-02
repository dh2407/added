import { QuestionsGameModel } from '../../../../../generated-api/index'
import { SectionHandler } from '../SectionHandler';

export class QuestionsGameSection {
    public questionsGame: QuestionsGameModel;
    
    private _sectionHandler: SectionHandler;

    constructor(sectionHandler: SectionHandler ) {
        this._sectionHandler = sectionHandler;
        this.questionsGame = sectionHandler.currentSection.questions_game!;
    }
}
