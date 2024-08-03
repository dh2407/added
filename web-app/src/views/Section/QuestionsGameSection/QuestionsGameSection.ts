import { QuestionModel, QuestionsGameModel } from '../../../../../generated-api';

interface QuestionStep {
    questionHtml: string,
    responses: {
        id: string,
        html: string,
        isSelected: boolean,
        explanation?: string,
        selectedScore?: number,
        score?: number,
    }[],
    openedResponseExplanationId?: string,
}

export class QuestionsGameSection {
    private _questionSteps: QuestionStep[];
    private _currentQuestionStepIndex: number;
    private _goToNextSectionCallback: (params?: object) => void;

    constructor(questions_game: QuestionsGameModel, goToNextSection: (params?: object) => void) {
        // only multiple choice question for now, TODO: fix this when adding MultipleChoiceQuestion and FillInTheBlankQuestion separtion
        this._questionSteps = questions_game.questions.map((question: QuestionModel) => ({
            questionHtml: question.multiple_choice_question!.html,
            responses: question.multiple_choice_question!.responses.map(response => ({ 
                id: response.id,
                html: response.html,
                isSelected: false,
                selectedScore: response.selected_score,
                explanation: response.explanation,
            })),
        }));
        this._goToNextSectionCallback = goToNextSection;
        this._currentQuestionStepIndex = 0;
    }
    
    private get _hasNextStep(): boolean {
        console.log('this._currentQuestionStepIndex < this._questionSteps.length - 1;', this._currentQuestionStepIndex < this._questionSteps.length - 1)
        return this._currentQuestionStepIndex < this._questionSteps.length - 1;
    }

     
    private _goNextQuestionStep() {
        if (this._hasNextStep) {
            this._currentQuestionStepIndex++;
            return;
        }
        throw new Error("No next step")
    }

    public goNext() {
        if (this._hasNextStep) {
            this._goNextQuestionStep();
        } else {
            const params = {
                score: this._calculateQuestionGameScore()
            }
            this._goToNextSectionCallback(params)
        }
    }

    public get currentQuestionStep(): QuestionStep  {
        return this._questionSteps[this._currentQuestionStepIndex];
    }

    private _calculateQuestionScore(questionStep: QuestionStep): number {
        return questionStep.responses.reduce((totalScore, response) => {
            if (response.isSelected && response.selectedScore !== undefined) {
                return totalScore + response.selectedScore;
            }
            return totalScore;
        }, 0);
    }

    private _calculateQuestionGameScore(): number {
        return this._questionSteps.reduce((totalGameScore, questionStep) => {
            return totalGameScore + this._calculateQuestionScore(questionStep);
        }, 0);
    }
    
    public getScore(): number {
        return this._questionSteps.reduce((totalScore, questionStep) => {
            return totalScore + this._calculateQuestionScore(questionStep);
        }, 0);
    }
    
    public setSelectedResponse(responseId: string) {
        this.currentQuestionStep.responses = this.currentQuestionStep.responses.map((response) => ({
            ...response,
            isSelected: response.id === responseId ? true : false,
        }))
    }

    public get isAtLeaseOneResponseSelected(): boolean {
        return this.currentQuestionStep.responses.some(response => response.isSelected)
    }
}
