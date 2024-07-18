<script setup lang="ts">
import ImportantDevicesSvg from '@/assets/svgs/important_devices.svg';
import SubSubjectCard from '../../components/Cards/SubSubjectCard.vue'
import { onMounted } from 'vue';
import { useSubjectStore } from '@/stores/useSubjectModule';
import { SubjectWithChildren } from '@/utils/types';

const subjectStore = useSubjectStore();

const props = defineProps({
    id: {
        type: String,
        required: true,
    },
});

onMounted(() => {
    subjectStore.fetchSubjectWithChildren(props.id);
});

</script>

<template>
    <div v-if="subjectStore.isLoading" class="loading-spinner">
        <v-progress-circular indeterminate color="primary"></v-progress-circular>
    </div>
    <div class="subject-details-page-container" v-else>
        <div class="subject-details-content-conatiner">
            <div class="title">
                {{ subjectStore.subject?.title }}
            </div>
            <div class="description-sub-subjects-container" v-if="subjectStore.subject">
                <div class="description" v-html="subjectStore.subject?.description"></div>
                <div class="sub-subjects-list-container">
                    <SubSubjectCard
                        v-for="(subSubject, index) in (subjectStore.subject as SubjectWithChildren).children"
                        :key="index" :title="subSubject.title" :icon="(ImportantDevicesSvg as Object)"
                        :subSubjectId="subSubject.id" :subjectId="subjectStore.subject.id" />
                </div>
            </div>
        </div>
    </div>
</template>

<style lang="scss" scoped>
.loading-spinner {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
    width: 100%;
}

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

@media (max-width: map-get($breakpoints, md)) {
    .subject-details-page-container {
        .subject-details-content-conatiner {
            .description-sub-subjects-container {
                flex-direction: column;
        
                .description {
                    width: 100%
                }
        
                .sub-subjects-list-container {
                    width: 100%;
                    gap: 6px;
                }
            }
        }
    }
}
</style>