import { QuestionModel, QuestionsGameModel } from '../../../../../generated-api';

export interface QuestionResponse {
    id: string,
    html: string,
    isSelected: boolean,
    isExplanationOpen: boolean,
    explanation?: string,
    selectedScore?: number,
    score?: number,
}
export interface QuestionStep {
    questionHtml: string,
    responses: QuestionResponse[],
    openedResponseExplanationId?: string,
}

export class QuestionsGameSection {
    private _questionSteps: QuestionStep[];
    private _currentQuestionStepIndex: number;
    private _goToNextSectionCallback: (params?: object) => void;
    private _showExplanations: boolean;

    constructor(questions_game: QuestionsGameModel, goToNextSection: (params?: object) => void, params?: Record<string, any>) {
        // only multiple choice question for now, TODO: fix this when adding MultipleChoiceQuestion and FillInTheBlankQuestion separtion
        this._questionSteps = questions_game.questions.map((question: QuestionModel) => ({
            questionHtml: question.multiple_choice_question!.html,
            responses: question.multiple_choice_question!.responses.map(response => ({ 
                id: response.id,
                html: response.html,
                isSelected: false,
                isExplanationOpen: false,
                selectedScore: response.selected_score,
                explanation: response.explanation,
            })),
        }));
        this._goToNextSectionCallback = goToNextSection;
        this._currentQuestionStepIndex = 0;
        this._showExplanations = params?.showExplanations ?? false;
    }
    
    private get _hasNextStep(): boolean {
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
                score: this._calculateQuestionGameScore(),
            }
            this._goToNextSectionCallback(params)
        }
    }

    public get currentQuestionStep(): QuestionStep  {
        return this._questionSteps[this._currentQuestionStepIndex];
    }

    public setOpenExplanation(responseId: string) {
        this.currentQuestionStep.responses = this.currentQuestionStep.responses.map((response) => ({
            ...response,
            isExplanationOpen: response.id === responseId ? !response.isExplanationOpen : false,
        }))
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
    
    public setSelectedResponse(responseId: string, newVal: boolean) {
        this.currentQuestionStep.responses = this.currentQuestionStep.responses.map((response) => ({
            ...response,
            isSelected: response.id === responseId ? newVal : response.isSelected,
        }))
    }

    public get isAtLeaseOneResponseSelected(): boolean {
        return this.currentQuestionStep.responses.some(response => response.isSelected)
    }

    public get showExplanations(): boolean {
        return this._showExplanations;
    }
}
