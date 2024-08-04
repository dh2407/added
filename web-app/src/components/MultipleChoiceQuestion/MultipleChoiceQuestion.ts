import { MultipleChoiceQuestionModel } from "../../../../generated-api";

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
}

export class MultipleChoiceQuestion {
    private _showExplanations: boolean;
    private _questionStep: QuestionStep;
    private _goNextCallback: (score: number, params?: object) => void;
    private _params?: Record<string, any>;

    constructor(question: MultipleChoiceQuestionModel, goNext: (score: number, params?: Record<string, any>) => void, params?: Record<string, any>) {
        this._questionStep = {
            questionHtml: question.html,
            responses: question.responses.map(response => ({ 
                id: response.id,
                html: response.html,
                isSelected: false,
                isExplanationOpen: false,
                selectedScore: response.selected_score,
                explanation: response.explanation,
            })),
        }
        this._params = params
        this._showExplanations = this._params?.showExplanations ?? false;
        this._goNextCallback = goNext;
    }

    private _calculateQuestionScore(): number {
        return this._questionStep.responses.reduce((totalScore, response) => {
            if (response.isSelected && response.selectedScore !== undefined) {
                return totalScore + response.selectedScore;
            }
            return totalScore;
        }, 0);
    }

    public setOpenExplanation(responseId: string) {
        this._questionStep.responses = this._questionStep.responses.map((response) => ({
            ...response,
            isExplanationOpen: response.id === responseId ? !response.isExplanationOpen : false,
        }))
    }
    
    public setSelectedResponse(responseId: string, newVal: boolean) {
        this._questionStep.responses = this._questionStep.responses.map((response) => ({
            ...response,
            isSelected: response.id === responseId ? newVal : response.isSelected,
        }))
    }

    public get isAtLeaseOneResponseSelected(): boolean {
        return this._questionStep.responses.some(response => response.isSelected)
    }

    public get showExplanations(): boolean {
        return this._showExplanations;
    }

    public submitQuestion() {
        const score = this._calculateQuestionScore();
        this._goNextCallback(score, this._params);
    }

    public get currentQuestionStep() {
        return this._questionStep;
    }
}