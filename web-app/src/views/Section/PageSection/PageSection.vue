<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { PageSection } from './PageSection';
import { ApiService } from '@/services/index';
import LoadingComponent from '@/components/Loading/LoadingComponent.vue';

const pageSection = ref<PageSection | null>(null);
const isLoading = ref(true);

onMounted(async () => {
    try {
        const { data, error } = await ApiService.sectionGetNextSectionPost({ section_id: "d6e3a8c3-466b-4f12-9b0e-8417fda41a9b" });
        if (error) {
            console.error('Error:', error);
            return;
        }
        if (data) {
            pageSection.value = new PageSection(data.data);
            console.log(pageSection.value)
        }
    } catch (err) {
        console.error('Fetch error:', err);
    } finally {
        isLoading.value = false;
    }
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
