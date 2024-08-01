<script setup lang="ts">
import { ref, defineProps, onMounted } from 'vue';
import { StorySection } from './StorySection';
import LoadingComponent from '@/components/Loading/LoadingComponent.vue';
import ArrowNextSvg from '@/assets/svgs/arrow-next.svg';
import ArrowPreviousSvg from '@/assets/svgs/arrow-previous.svg';
import AudioPlayer from '@/components/AudioPlayer/AudioPlayer.vue';

const props = defineProps<{ sectionInstance: StorySection }>();

const storySection = ref<StorySection | null>(null);
const isLoading = ref(true);

onMounted(() => {
    // Use the injected section instance from props
    storySection.value = props.sectionInstance;
    isLoading.value = false;
});

const handleAudioEnd = () => {
    storySection.value?.goNext();
};
</script>

<template>
    <div>
        <LoadingComponent v-if="isLoading" />
        <div class="story-section-content-container" v-if="storySection">
            <!-- PROGRESS -->
            <v-progress-linear :location="false" color="#394038" height="12"
                :max="storySection.scenesTotalNumberOfSegments" min="1"
                :model-value="storySection.progressionValue"></v-progress-linear>
            <!-- IMAGE CONTAINER -->
            <div class="scene-image-container">
                <div class="arrow-container next" v-if="storySection.isNextButtonDisplayed"
                    @click="storySection.goNext">
                    <ArrowNextSvg />
                </div>
                <div class="arrow-container previous" v-if="storySection.isPreviousButtonDisplayed"
                    @click="storySection.goPrevious">
                    <ArrowPreviousSvg />
                </div>
                <img class="scene-image" :src="storySection.currentSceneImageSrc" />
            </div>
            <!-- TEXT -->
            <div class="segment-text-container">
                <div v-html="storySection.currentSegmentText" />
            </div>
            <!-- AUDIO -->
            <AudioPlayer v-if="storySection.currentSegmentSoundSrc" :src="storySection.currentSegmentSoundSrc" :onEnded="handleAudioEnd" />
        </div>
    </div>
</template>

<style lang="scss" scoped>
.story-section-content-container {
    display: flex;
    flex-direction: column;
    height: 100vh;
    overflow: hidden;
    user-select: none;

    .scene-image-container {
        position: relative;
        flex: 1 1 auto;
        max-height: calc(100vh - 4rem - 12px);
        display: flex;
        justify-content: center;
        align-items: center;

        .scene-image {
            max-height: 100%;
            max-width: 100%;
            height: auto;
            width: auto;
        }
    }

    .segment-text-container {
        background-color: rgba(0, 0, 0, 0.7);
        display: flex;
        justify-content: flex-start;
        align-items: center;
        text-align: start;
        color: #fff;
        margin-top: auto;
        flex-shrink: 0;
        padding: 10px;
    }

    .arrow-container {
        position: absolute;
        top: 50%;
        height: 20px;
        width: 20px;
        transform: translateY(-50%);
        cursor: pointer;
    }

    .next {
        right: 0.5rem;
    }

    .previous {
        left: 0.5rem;
    }

    .v-progress-linear {
        flex-shrink: 0;
    }
}
</style>
