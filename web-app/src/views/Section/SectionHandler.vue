<script setup lang="ts">
import { ref, onMounted, reactive, watch } from 'vue';
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
const sectionHandler = reactive({ instance: null as SectionHandler | null });
const isLoadingBeforeInit = ref(false);
const sectionViewComponent = ref<SectionViewComponent | null>(null);
const componentKey = ref<string>("0");

const fetchSection = async (subjectId: string) => {
    try {
        isLoadingBeforeInit.value = true;
        const { data, error } = await ApiService.sectionGetFirstSectionPost({ subject_id: subjectId });
        if (error) {
            console.error('Error:', error);
            return;
        }
        if (data) {
            sectionHandler.instance = new SectionHandler(data.data);
        }
    } catch (err) {
        console.error('Fetch error:', err);
    } finally {
        isLoadingBeforeInit.value = false;
    }
};

onMounted(() => {
    const subjectId: string = route.params.subject_id as string;
    fetchSection(subjectId);
});

watch(() => sectionHandler.instance?.currentSectionInstance, (newInstance) => {
    if (newInstance) {
        sectionViewComponent.value = sectionViewComponentMap[sectionHandler.instance!.currentSection.kind];
        componentKey.value = sectionHandler.instance!.currentSection.section_id;
    }
});
</script>

<template>
    <div>
        <LoadingComponent v-if="isLoadingBeforeInit || sectionHandler.instance?.isLoading" />
        <component
            v-if="sectionHandler.instance && !isLoadingBeforeInit && !sectionHandler.instance.isLoading"
            :is="sectionViewComponent"
            :key="componentKey"
            :sectionInstance="sectionHandler.instance.currentSectionInstance"
        />
    </div>
</template>

<style lang="scss" scoped>
/* Your styles here */
</style>
