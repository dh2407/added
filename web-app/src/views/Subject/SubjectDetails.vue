<script setup lang="ts">
import ImportantDevicesSvg from '@/assets/svgs/important_devices.svg';
import SubSubjectCard from '../../components/Cards/SubSubjectCard.vue'

const props = defineProps({
    id: {
        type: String,
        required: true,
    },
});

const subjectId = props.id;

const subject = {
    id: subjectId,
    title: "Mastering SQL: A Comprehensive Guide to Reading Data",
    description: `<p>The SELECT command in SQL allows you to retrieve specific data from a database, refine results by applying conditions, organize the output in a particular order, and perform calculations and aggregations for thorough data analysis.
    In the sections below, we will explore these functionalities in detail, providing practical examples and explanations to enhance your SQL proficiency.</p>`,
    subSubjectsList: [
        {
            title: "Retrieving Specific Data",
            icon: ImportantDevicesSvg as Object,
            id: "1"
        },
        {
            title: "Retrieving Specific Data",
            icon: ImportantDevicesSvg as Object,
            id: "1"
        },
        {
            title: "Retrieving Specific Data",
            icon: ImportantDevicesSvg as Object,
            id: "1"
        },
    ]
}
</script>

<template>
    <div class="subject-details-page-container">
        <div class="subject-details-content-conatiner">
            <div class="title">
                {{ subject.title }}
            </div>
            <div class="description-sub-subjects-container">
                <div class="description" v-html="subject.description"></div>
                <div class="sub-subjects-list-container">
                    <SubSubjectCard v-for="(subSubject, index) in subject.subSubjectsList" :key="index" 
                    :title="subSubject.title"
                    :icon="subSubject.icon"
                    :subSubjectId="subSubject.id"
                    :subjectId="subjectId"
                    />
                </div>
            </div>
        </div>
    </div>
</template>

<style lang="scss" scoped>
.subject-details-page-container {
    display: flex;
    flex-direction: column;
    height: 100%;
    width: 100%;
    justify-content: center;
    .subject-details-content-conatiner {
        padding: 12px;
        margin: 24px;
        .title {
            font-size: 22px;
            font-weight: 700;
        }
        .description-sub-subjects-container {
            display: flex;
            flex-direction: row;
            gap: 26px;
            padding: 18px 0;
            .description {
                width: 50%
            }
            .sub-subjects-list-container {
                width: 50%;
                gap: 6px;
            }
        }
    }
}
</style>