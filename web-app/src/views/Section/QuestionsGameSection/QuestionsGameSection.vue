<script setup lang="ts">
import { reactive, defineProps, onMounted } from 'vue';
import { QuestionsGameSection } from './QuestionsGameSection';
import RadioResponse from '@/components/Responses/RadioResponse.vue';

const props = defineProps<{ sectionInstance: QuestionsGameSection }>();

const state = reactive({
  questionsGameSection: null as QuestionsGameSection | null,
  isLoading: true,
});

onMounted(() => {
  // Use the injected section instance from props
  state.questionsGameSection = props.sectionInstance;
});
</script>

<template>
  <div class="questions-game-section-content-container" v-if="state.questionsGameSection">
    <div v-html="state.questionsGameSection.currentQuestionStep.questionHtml" />
    <div class="responses-container">
      <RadioResponse v-for="response in state.questionsGameSection.currentQuestionStep.responses" :html="response.html"
        :isChecked="response.isSelected"
        @update:isChecked="state.questionsGameSection.setSelectedResponse(response.id)" />
    </div>
    <div class="next-button-container" v-if="state.questionsGameSection.isAtLeaseOneResponseSelected">
      <ForwardButton :onClick="() => state.questionsGameSection?.goNext()"/>
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
