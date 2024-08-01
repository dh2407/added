<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import { SectionHandler } from './SectionHandler';
import { ApiService } from '@/services/index';
import LoadingComponent from '@/components/Loading/LoadingComponent.vue';

import QuestionsGameSectionView from './QuestionsGameSection/QuestionsGameSection.vue';
import StorySectionView from './StorySection/StorySection.vue';
import PageSectionView from './PageSection/PageSection.vue';
import { SectionKindEnum } from '../../../../generated-api';

type SectionViewComponent =
  | typeof QuestionsGameSectionView
  | typeof StorySectionView
  | typeof PageSectionView;

const sectionViewComponentMap: { [key in SectionKindEnum]: SectionViewComponent } = {
    QUESTIONS_GAME: QuestionsGameSectionView,
    STORY: StorySectionView,
    PAGE: PageSectionView,
};

const route = useRoute();
const sectionHandler = ref<SectionHandler | null>(null);
const isLoading = ref(true);
const sectionViewComponent = ref<SectionViewComponent | null>(null);

const fetchSection = async (subjectId: string) => {
    try {
        const { data, error } = await ApiService.sectionGetFirstSectionPost({ subject_id: subjectId });
        if (error) {
            console.error('Error:', error);
            return;
        }
        if (data) {
            sectionHandler.value = new SectionHandler(data.data);
            sectionViewComponent.value = sectionViewComponentMap[sectionHandler.value.currentSection.kind];
        }
    } catch (err) {
        console.error('Fetch error:', err);
    } finally {
        isLoading.value = false;
    }
};

onMounted(() => {
    const subjectId: string = route.params.subject_id as string;
    fetchSection(subjectId);
});

</script>

<template>
    <div>
        <LoadingComponent v-if="isLoading" />
        <component
            v-if="sectionHandler && !isLoading"
            :is="sectionViewComponent"
            :section="sectionHandler.currentSection"
            :sectionInstance="sectionHandler.currentSectionInstance"
        />
    </div>
</template>

<style lang="scss" scoped>
/* Your styles here */
</style>
