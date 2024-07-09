<script setup lang="ts">
import { QuestionTypeEnum, MultipleChoiceQuestion } from '@/utils/types'
import { onMounted } from 'vue';
import { useQuestionStore } from '@/stores/useQuestionModule';
import MultipleChoiceQuestionComp from '@/components/Questions/MultipleChoiceQuestionComp.vue';

const questionStore = useQuestionStore();

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

onMounted(() => {
    questionStore.fetchQuestionsOfSubject(props.subSubjectId);
});

</script>

<template>
    <div class="sub-subject-page-container" v-if="questionStore.questionsList[0]">
        <!-- FIX THIS TO LOOP THROUGH QUESTION LOGIC AND NOT IN RENDER + FIX ENUM TYPE EQUALITY -->
        <!-- <div v-for="(question, index) in questionStore.questionsList" :key="index"> -->
            <MultipleChoiceQuestionComp v-if="questionStore.questionsList[0].type.toString() === 'MULTIPLE_CHOICE_QUESTION'"
                :question="(questionStore.questionsList[0] as MultipleChoiceQuestion)" />
        <!-- </div> -->
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