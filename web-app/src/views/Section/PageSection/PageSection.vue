<script setup lang="ts">
import { ref, defineProps, onMounted } from 'vue';
import { PageSection } from './PageSection';
import LoadingComponent from '@/components/Loading/LoadingComponent.vue';

const props = defineProps<{ sectionInstance: PageSection }>();

const pageSection = ref<PageSection | null>(null);
const isLoading = ref(true);

onMounted(() => {
    // Use the injected section instance from props
    pageSection.value = props.sectionInstance;
    isLoading.value = false;
});
</script>

<template>
    <div>
        <LoadingComponent v-if="isLoading" />
        <div class="page-section-content-container" v-if="pageSection">
            <div v-html="pageSection.page.html"/>
            <div class="page-actions-container" v-for="action in pageSection.page.actions">
                <ForwardButtonWithText :text="action.label" :onClick="() => console.log('GO TO SECTION', action.next_section_id)" />
            </div>
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
