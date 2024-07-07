<script setup lang="ts">
import { QuestionTypeEnum } from '@/utils/constants'
import MultipleChoiceQuestion from '@/components/Questions/MultipleChoiceQuestion.vue';

const subSubject = {
    id: "1",
    question: [
        {
            id: "1",
            type: QuestionTypeEnum.MULTIPLE_CHOICE_QUESTION,
            props: {
                questionText: "Which SQL command is used to modify existing records in a table ?",
                wrongResponseChoices: ["CHANGE", "EDIT", "MODIFY"],
                correctResponseChoices: ["UPDATE"],
            }
        },
    ]
}
</script>

<template>
    <div class="sub-subject-page-container">
        <div v-for="(question, index) in subSubject.question" :key="index">
            <MultipleChoiceQuestion v-if="question.type === QuestionTypeEnum.MULTIPLE_CHOICE_QUESTION"
                :question="question" />
        </div>
    </div>
</template>

<style lang="scss" scoped>
.sub-subject-page-container {
    display: flex;
    flex-direction: column;
    height: 100%;
    width: 100%;
    justify-content: center;
}
</style>