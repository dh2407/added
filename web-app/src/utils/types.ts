export enum QuestionTypeEnum {
    MULTIPLE_CHOICE_QUESTION = "MULTIPLE_CHOICE_QUESTION",
    FILL_IN_THE_BLANKS_QUESTION = "FILL_IN_THE_BLANKS_QUESTION"
}

export interface Subject {
    id: number;
    title: string;
    description: string;
}

export interface SubjectWithChildren extends Subject {
    children: Subject[] | null;
}

export interface SubSubject extends Subject {
    parentId: number;
    questions: Array<MultipleChoiceQuestion>
}

export interface Question {
    id: number,
    type: QuestionTypeEnum,
    props: PropsQuestion
}

export interface PropsQuestion {
    questionText: string,
}

export interface MultipleChoiceQuestion extends PropsQuestion {
    wrongResponseChoices: Array<string>,
    correctResponseChoices: Array<string>,
}
