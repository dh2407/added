<script setup lang="ts">
import { useRouter, useRoute } from 'vue-router';

const router = useRouter();
const route = useRoute();

const handleClick = () => {
  const subjectId = route.params.subject_id as string;
  router.push({ name: 'SectionHandler', params: { subject_id: subjectId } });
};
</script>

<template>
  <div class="button-container">
    <v-btn @click="handleClick" color="primary">START DEMO</v-btn>
  </div>
</template>

<style lang="scss" scoped>
.button-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
}
</style>
