import { MultipleChoiceQuestion } from '@/components/MultipleChoiceQuestion/MultipleChoiceQuestion';
import { QuestionModel, QuestionsGameModel } from '#/index';
import { ref } from 'vue';

export class QuestionsGameSection {
    public currentQuestionGameInstance = ref<MultipleChoiceQuestion | null>(null);

    private _questions: QuestionModel[];
    private _currentQuestionIndex: number;
    private _goToNextSectionCallback: (params?: object) => void;
    private _totalScore: number;

    constructor(questions_game: QuestionsGameModel, goToNextSection: (params?: object) => void, params?: Record<string, any>) {
        this._questions = questions_game.questions
        this._goToNextSectionCallback = goToNextSection;
        this._currentQuestionIndex = 0;
        this.currentQuestionGameInstance.value = this._createQuestionGameInstance(params)
        this._totalScore = 0;
    }

    private _createQuestionGameInstance(params?: object) {
        switch (this.currentQuestion.kind) {
            case 'MULTIPLE_CHOICE_QUESTION':
                return new MultipleChoiceQuestion(this.currentQuestion.multiple_choice_question!, this.goNext.bind(this), params);
            default:
                throw new Error(`Unknown section type: ${this.currentQuestion.kind}`);
        }
    }

    private get _hasNextQuestion(): boolean {
        return this._currentQuestionIndex < this._questions.length - 1;
    }

    private _goNextQuestion() {
        if (this._hasNextQuestion) {
            this._currentQuestionIndex++;
            return;
        }
        throw new Error("No next step")
    }

    public goNext(score: number, params?: Record<string, any>) {
        this._totalScore += score;
        if (this._hasNextQuestion) {
            this._goNextQuestion();
            this.currentQuestionGameInstance.value = this._createQuestionGameInstance(params)
        } else {
            const params = {
                score: this._totalScore,
            }
            this._goToNextSectionCallback(params)
        }
    }

    public get currentQuestion(): QuestionModel {
        return this._questions[this._currentQuestionIndex];
    }
}
