<script setup lang="ts">
import { reactive, defineProps, onMounted, watch } from 'vue';
import { SoundHandler, SoundStateEnum } from './SoundHandler';
import { StorySection } from './StorySection';
import ArrowNextSvg from '@/assets/svgs/arrow-next.svg';
import ArrowPreviousSvg from '@/assets/svgs/arrow-previous.svg';
import { onUnmounted } from 'vue';

const props = defineProps<{ sectionInstance: StorySection }>();

const state = reactive({
  storySection: null as StorySection | null,
  soundHandler: new SoundHandler((status) => {
    if (status === SoundStateEnum.ENDED) {
      state.storySection?.goNext();
    }
  }),
});

onMounted(() => {
  state.storySection = props.sectionInstance;
});

onUnmounted(() => {
  state.soundHandler.stopSound();
});

watch(() => state.storySection?.progressionValue, () => {
  playCurrentSegmentSound();
});

function playCurrentSegmentSound() {
  const soundSrc = state.storySection?.currentSegmentSoundSrc;
  if (soundSrc) state.soundHandler.playSound(soundSrc);
}
</script>

<template>
  <div class="story-section-content-container" v-if="state.storySection">
    <!-- PROGRESS -->
    <v-progress-linear :location="false" color="#394038" height="12"
      :max="state.storySection.scenesTotalNumberOfSegments" min="1"
      :model-value="state.storySection.progressionValue"></v-progress-linear>
    <!-- IMAGE CONTAINER -->
    <div class="scene-image-container">
      <div class="arrow-container next" v-if="state.storySection.isNextButtonDisplayed"
        @click="state.storySection.goNext">
        <ArrowNextSvg />
      </div>
      <div class="arrow-container previous" v-if="state.storySection.isPreviousButtonDisplayed"
        @click="state.storySection.goPrevious">
        <ArrowPreviousSvg />
      </div>
      <img class="scene-image" :src="state.storySection.currentSceneImageSrc" />
    </div>
    <!-- TEXT -->
    <div class="segment-text-container">
      <div v-html="state.storySection.currentSegmentText" />
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
