<script setup lang="ts">
import ImportantDevicesSvg from '@/assets/svgs/important_devices.svg';

const subjectsList = [
    { id: "1", title: "Mastering SQL: A Comprehensive Guide to Reading Data", icon: ImportantDevicesSvg },
    { id: "2", title: "Another Subject", icon: ImportantDevicesSvg },
    { id: "3", title: "Yet Another Subject", icon: ImportantDevicesSvg }
];
</script>

<template>
    <div class="subjects-page-container">
        <div class="subject-list-container">
            <SubjectCard v-for="(subject, index) in subjectsList" :key="index" :title="subject.title"
                :icon="subject.icon" :subjectId="subject.id" />
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