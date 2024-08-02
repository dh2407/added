<script setup lang="ts">
import { reactive, defineProps, onMounted } from 'vue';
import { PageSection } from './PageSection';

const props = defineProps<{ sectionInstance: PageSection }>();

const state = reactive({
  pageSection: null as PageSection | null,
});

onMounted(() => {
  // Use the injected section instance from props
  state.pageSection = props.sectionInstance;
});
</script>

<template>
  <div class="page-section-content-container" v-if="state.pageSection"
    :style="{ backgroundColor: state.pageSection.page.background_color }">
    <div v-html="state.pageSection.page.html" />
    <div class="page-actions-container" v-for="action in state.pageSection.page.actions" :key="action.label">
      <ForwardButtonWithText :text="action.label"
        :onClick="() => state.pageSection?.goToSection(action.next_section_id)" />
    </div>
  </div>
</template>

<style lang="scss" scoped>
.page-section-content-container {
  display: flex;
  flex-direction: column;
  height: 100vh;
  overflow: hidden;
  user-select: none;
  padding: 20px;
  justify-content: space-between;

  .page-actions-container {
    display: flex;
    flex-direction: column;
    gap: 15px;
  }
}
</style>
