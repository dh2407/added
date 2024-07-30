<script setup lang="ts">
import { ref, onUnmounted } from 'vue';

interface Props {
  src: string;
  onEnded: () => void;
}

const props = defineProps<Props>();
const audioElement = ref<HTMLAudioElement | null>(null);

const playAudio = () => {
  if (audioElement.value) {
    audioElement.value.play().then(() => {
      console.log('Audio playback started successfully');
    }).catch((err) => {
      console.error('Audio play error:', err);
    });
  }
};

onUnmounted(() => {
  if (audioElement.value) {
    audioElement.value.removeEventListener('ended', props.onEnded);
  }
});
</script>

<template>
  <div>
    <audio :src="props.src" ref="audioElement" @ended="props.onEnded"></audio>
    <button @click="playAudio">
      Play
    </button>
  </div>
</template>
