<script setup lang="ts">
import { QuestionTypeEnum } from '@/utils/constants';
import { shuffleArray } from '@/utils/helpers';
import { computed, ref } from 'vue';

const props = defineProps({
    question: {
        type: Object as () => ({
            id: String,
            type: QuestionTypeEnum,
            props: {
                questionText: String,
                wrongResponseChoices: Array<String>,
                correctResponseChoices: Array<String>,
            },
        }),
        required: true,
    },
});

const mergedResponses = computed(() => {
    const allResponses = [
        ...props.question.props.wrongResponseChoices.map(choice => ({ text: choice, isCorrect: false })),
        ...props.question.props.correctResponseChoices.map(choice => ({ text: choice, isCorrect: true })),
    ];
    return shuffleArray(allResponses);
});

const responseStates = ref(mergedResponses.value.map(response => ({ ...response, isChecked: false, isCorrectSubmition: false })));
const isSubmitted = ref(false);

const submitQuestion = () => {
    responseStates.value = responseStates.value.map(response => ({
        ...response,
        isCorrectSubmition: response.isCorrect ? response.isChecked : !response.isChecked,
    }));
    isSubmitted.value = true;
};
</script>

<template>
    <div class="multiple-choice-question-content-container">
        <div class="title">
            {{ props.question.props.questionText }}
        </div>
        <div class="response-list-container">
            <RadioResponse v-for="(response, index) in responseStates" :key="index" :text="response.text"
                :isChecked="response.isChecked" :isSubmitted="isSubmitted"
                :isCorrectSubmition="response.isCorrectSubmition" :isCorrectAnswer="response.isCorrect"
                @update:isChecked="response.isChecked = $event" />
        </div>
        <div class="submit-container">
            <ForwardButton @click="submitQuestion" />
        </div>
    </div>
</template>

<style lang="scss" scoped>
.multiple-choice-question-content-container {
    padding: 12px;
    margin: 24px;

    .title {
        font-size: 22px;
        font-weight: 700;
    }

    .response-list-container {
        display: flex;
        flex-direction: column;
        gap: 2px;
        padding: 16px 0;
    }

    .submit-container {
        margin-top: 16px;
        display: flex;
        justify-content: flex-end;
    }
}
</style>
