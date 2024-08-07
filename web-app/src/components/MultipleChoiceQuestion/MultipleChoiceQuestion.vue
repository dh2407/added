<script setup lang="ts">
import { reactive, onMounted } from 'vue';
import RadioResponse from '@/components/Responses/RadioResponse.vue';
import { MultipleChoiceQuestion } from './MultipleChoiceQuestion';

const props = defineProps<{ questionGameInstance: MultipleChoiceQuestion }>();

const state = reactive({
  multipleChoiceQuestion: null as MultipleChoiceQuestion | null,
});

onMounted(() => {
  // Use the injected section instance from props
  state.multipleChoiceQuestion = props.questionGameInstance;
});

</script>

<template>
  <div class="questions-game-section-content-container" v-if="state.multipleChoiceQuestion">
    <div v-html="state.multipleChoiceQuestion.currentQuestionStep.questionHtml" />
    <div class="responses-container">
      <RadioResponse 
        v-for="response in state.multipleChoiceQuestion.currentQuestionStep.responses" 
        :key="JSON.stringify(response)"
        :response="response"
        :showExplanations="state.multipleChoiceQuestion.showExplanations"
        :onToggle="state.multipleChoiceQuestion.setSelectedResponse.bind(state.multipleChoiceQuestion)"
        :onExplanationClicked="state.multipleChoiceQuestion.setOpenExplanation.bind(state.multipleChoiceQuestion)"
      />
    </div>
    <div class="next-button-container" v-if="state.multipleChoiceQuestion.isAtLeaseOneResponseSelected">
      <ForwardButton :onClick="() => state.multipleChoiceQuestion!.submitQuestion()"/>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.questions-game-section-content-container {
  display: flex;
  flex-direction: column;
  height: 100vh;
  overflow: hidden;
  user-select: none;
  padding: 20px;
  gap: 50px;

  .responses-container {
    display: flex;
    flex-direction: column;
    gap: 15px;
  }

  .next-button-container {
    margin-top: auto;
    display: flex;
    justify-content: flex-end;
  }
}
</style>
