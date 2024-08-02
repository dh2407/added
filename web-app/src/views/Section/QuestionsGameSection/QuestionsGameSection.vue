<script setup lang="ts">
import { reactive, defineProps, onMounted } from 'vue';
import { QuestionsGameSection } from './QuestionsGameSection';

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
    HI
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
  justify-content: space-between;
}
</style>
