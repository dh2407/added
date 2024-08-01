import { QuestionsGameModel } from '../../../../../generated-api/index'

export class QuestionsGameSection {
    public questionsGame: QuestionsGameModel;

    constructor(questionsGame: QuestionsGameModel ) {
        this.questionsGame = questionsGame;
    }
}
