<script setup lang="ts">
import { onMounted } from 'vue';
import { useSubjectStore } from '@/stores/useSubjectModule';
import ImportantDevicesSvg from '@/assets/svgs/important_devices.svg';

const subjectStore = useSubjectStore();

onMounted(() => {
  subjectStore.fetchMainSubjects();
});
</script>

<template>
  <div class="subjects-page-container">
    <div class="subject-list-container">
      <SubjectCard v-for="subject in subjectStore.subjectList" :key="subject.id" :title="subject.title"
        :icon="ImportantDevicesSvg" :subjectId="subject.id" />
    </div>
  </div>
</template>

<style lang="scss" scoped>
.subjects-page-container {
  display: flex;
  flex-direction: column;
  height: 100%;
  width: 100%;
  justify-content: center;
  align-items: center;

  .subject-list-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 16px;
  }
}
</style>
