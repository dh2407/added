export enum QuestionTypeEnum {
    MULTIPLE_CHOICE_QUESTION,
    FILL_IN_THE_BLANKS_QUESTION 
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
}

export interface MultipleChoiceQuestion extends Question {
    props: {
        questionText: string,
        wrongResponseChoices: Array<string>,
        correctResponseChoices: Array<string>,
    }
}
