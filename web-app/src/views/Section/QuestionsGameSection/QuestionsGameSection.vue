<script setup lang="ts">
import { reactive, watch, ref, onMounted } from 'vue';
import MultipleChoiceQuestionView from '@/components/MultipleChoiceQuestion/MultipleChoiceQuestion.vue';
import { QuestionKindEnum } from '#/index';
import { QuestionsGameSection } from './QuestionsGameSection';

type QuestionGameViewComponent =
  | typeof MultipleChoiceQuestionView
  | null

const questionGameViewComponentMap: { [key in QuestionKindEnum]: QuestionGameViewComponent } = {
    MULTIPLE_CHOICE_QUESTION: MultipleChoiceQuestionView,
    FILL_IN_THE_BLANKS_QUESTION: null,
};

const props = defineProps<{ sectionInstance: QuestionsGameSection }>();

const state = reactive({
  questionsGameSection: null as QuestionsGameSection | null,
  isLoading: true,
});

const questionGameViewComponent = ref<QuestionGameViewComponent | null>(null);
const componentKey = ref<string>("0");

onMounted(() => {
  state.questionsGameSection = props.sectionInstance as any;
});

watch(() => state.questionsGameSection?.currentQuestionGameInstance, (newInstance) => {
    if (newInstance) {
        questionGameViewComponent.value = questionGameViewComponentMap[state.questionsGameSection!.currentQuestion.kind];
        componentKey.value = state.questionsGameSection!.currentQuestion.id;
    }
});

</script>

<template>
  <component
    v-if="state.questionsGameSection"
    :is="questionGameViewComponent"
    :key="state.questionsGameSection.currentQuestion"
    :questionGameInstance="state.questionsGameSection.currentQuestionGameInstance"
  />
</template>

<style lang="scss" scoped>
</style>
