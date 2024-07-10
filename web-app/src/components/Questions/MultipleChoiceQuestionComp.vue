<script setup lang="ts">
import { computed, ComputedRef, Ref, ref, watch } from 'vue';
import { shuffleArray } from '@/utils/helpers';
import { useQuestionStore } from '@/stores/useQuestionModule';
import { Question } from '@/utils/types';

const questionStore = useQuestionStore();

const currentQuestion = computed(() => questionStore.currentQuestion);

const mergedResponses: Ref<any[]> = ref([]);

watch(currentQuestion as ComputedRef<Question>, (newQuestion: Question) => {
    if (newQuestion) {
        const allResponses = [
            ...(newQuestion.props as any).wrongResponseChoices.map((choice: any) => ({ text: choice, isCorrect: false })),
            ...(newQuestion.props as any).correctResponseChoices.map((choice: any) => ({ text: choice, isCorrect: true })),
        ];
        mergedResponses.value = shuffleArray(allResponses);
    }
}, { immediate: true });

const responseStates: Ref<any[]> = ref([]);
const isSubmitted = ref(false);

watch(mergedResponses, (responses) => {
    responseStates.value = responses.map((response: any) => ({ ...response, isChecked: false, isCorrectSubmition: false }));
}, { immediate: true });

const submitQuestion = () => {
    if (isSubmitted.value) {
        questionStore.nextQuestion();
        isSubmitted.value = false;
        return;
    }

    responseStates.value = responseStates.value.map(response => ({
        ...response,
        isCorrectSubmition: response.isCorrect ? response.isChecked : !response.isChecked,
    }));

    responseStates.value.forEach(response => {
        if (response.isCorrectSubmition) {
            if (response.isCorrect) {
                questionStore.updateScore(2);
            } 
        } else {
            questionStore.updateScore(-1);
        }
    });

    isSubmitted.value = true;
};
</script>

<template>
    <div class="multiple-choice-question-content-container" v-if="currentQuestion">
        <div class="title">
            {{ currentQuestion.props.questionText }}
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
