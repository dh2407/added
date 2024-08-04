import { QuestionResponse } from "@/views/Section/QuestionsGameSection/QuestionsGameSection";

export class RadioResponse {
    private _id: string;
    private _html: string;
    private _isChecked: boolean; 
    private _showExplanations: boolean;
    private _isExplanationOpen: boolean;
    private _explanation?: string; 
    private _selectedScore?: number;
    private _onToggleCallback: (responseId: string, newVal: boolean) => void;
    private _onExplanationClickCallback: (responseId: string) => void;

    constructor(response: QuestionResponse, showExplanations: boolean, onToggle: (responseId: string, newVal: boolean) => void, onExplanationClick: (responseId: string) => void) {
        this._id = response.id
        this._html = response.html;
        this._isChecked = response.isSelected;
        this._showExplanations = showExplanations;
        this._explanation = response.explanation;
        this._isExplanationOpen = response.isExplanationOpen;
        this._selectedScore = response.selectedScore;
        this._onToggleCallback = onToggle.bind(this)
        this._onExplanationClickCallback = onExplanationClick.bind(this)
    }

    private get _isExplanationEmpty(): boolean {
        if (this._explanation && this._explanation.length > 0) return false
        return true
    }

    public toggle(){
        this._isChecked = !this._isChecked;
        this._onToggleCallback(this._id, this._isChecked)
    }

    public handleExplanationClicked() {
        this._onExplanationClickCallback(this._id);
    }

    public get html(): string {
        return this._html
    }

    public get isChecked(): boolean {
        return this._isChecked
    }

    public get explanation(): string | undefined {
        return this._explanation
    }

    public get isExplanationOpen(): boolean {
        return this._isExplanationOpen;
    }

    public get selectedScoreColor(): string {
        if (this._selectedScore){ 
            return this._selectedScore > 0 ? "#039033" : "red"
        }
        return "#000000"
    }
    public get selectedScore(): string | undefined {
        if (this._selectedScore !== undefined) {
            const scoreString = this._selectedScore.toString();
            return this._selectedScore > 0 ? `+${scoreString}` : scoreString;
        }
    }
    
    public get showExplanationButton(): boolean {
        return this._showExplanations && !this._isExplanationEmpty;
    }
}