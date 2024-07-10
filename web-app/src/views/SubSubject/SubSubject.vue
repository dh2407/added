<script setup lang="ts">
import { onMounted, computed } from 'vue';
import { useQuestionStore } from '@/stores/useQuestionModule';
import MultipleChoiceQuestionComp from '@/components/Questions/MultipleChoiceQuestionComp.vue';
import { QuestionTypeEnum } from '@/utils/types';
import { useRouter } from 'vue-router';

const questionStore = useQuestionStore();
const router = useRouter();

const props = defineProps({
    subjectId: {
        type: String,
        required: true,
    },
    subSubjectId: {
        type: String,
        required: true,
    },
});

const isMultipleChoiceQuestion = computed(() => {
    const currentQuestion = questionStore.currentQuestion;
    return currentQuestion && currentQuestion.type === QuestionTypeEnum.MULTIPLE_CHOICE_QUESTION;
});

const allQuestionsAnswered = computed(() => {
    return questionStore.currentQuestionIndex >= questionStore.questionsList.length;
});

onMounted(() => {
    questionStore.fetchQuestionsOfSubject(props.subSubjectId);
});

const redirectToSubjectDetails = () => {
    const subjectId = props.subjectId;
    if (subjectId) {
        router.push({
            name: 'SubjectDetailsView',
            params: { id: subjectId }
        });
    } else {
        console.error('Subject ID is required to navigate to SubjectDetailsView.');
    }
}

</script>

<template>
    <div v-if="questionStore.isLoading" class="loading-spinner">
        <v-progress-circular indeterminate color="primary"></v-progress-circular>
    </div>
    <div v-else class="sub-subject-page-container">
        <div v-if="!allQuestionsAnswered">
            <MultipleChoiceQuestionComp v-if="isMultipleChoiceQuestion" />
        </div>
        <div v-else class="score-recap">
            <h2>Score Recap</h2>
            <p>Questions Answered: {{ questionStore.questionsList.length }}</p>
            <p>Total Score: {{ questionStore.score }}</p>
            <v-btn class="return-to-subject-btn" :onClick="redirectToSubjectDetails"> Return to subjects </v-btn>
        </div>
    </div>
</template>

<style lang="scss" scoped>
.loading-spinner {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
    width: 100%;
}

.sub-subject-page-container {
    display: flex;
    flex-direction: column;
    height: 100%;
    width: 100%;
    justify-content: center;
}

.score-recap {
    display: flex;
    flex-direction: column;
    height: 100%;
    width: 100%;
    justify-content: center;
    align-items: center;
    gap: 10px;
}

.return-to-subject-btn {
    margin-top: 20px;
}
</style>
