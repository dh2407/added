<script setup lang="ts">
import { ref, defineProps, onMounted } from 'vue';
import { QuestionsGameSection } from './QuestionsGameSection';
import LoadingComponent from '@/components/Loading/LoadingComponent.vue';

const props = defineProps<{ sectionInstance: QuestionsGameSection }>();

const questionsGameSection = ref<QuestionsGameSection | null>(null);
const isLoading = ref(true);

onMounted(() => {
    // Use the injected section instance from props
    questionsGameSection.value = props.sectionInstance;
    isLoading.value = false;
});
</script>

<template>
    <div>
        <LoadingComponent v-if="isLoading" />
        <div class="questions-game-section-content-container" v-if="questionsGameSection">
            HI
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
    justify-content: space-between;
}
</style>
