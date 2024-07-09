<script setup lang="ts">
import { ref, markRaw } from 'vue'
import { useRouter } from 'vue-router';
import ForwardButton from '@/components/Buttons/ForwardButton.vue';

const router = useRouter();

const props = defineProps({
    title: {
        type: String,
        required: true,
    },
    icon: {
        type: Object,
        required: true,
    },
    subjectId: {
        type: Number,
        required: true,
    },
});

const IconComponent = ref(markRaw(props.icon))

const redirectToSubjectDetails = () => {
    const subjectId = props.subjectId;
    if (subjectId) {
        router.push({
            name: 'SubjectDetailsView',
            params: { id: subjectId }
        });
    } else {
        console.error('Subject ID is required to navigate to SubjectDetailsView.');
    }
}

</script>

<template>
    <div class="subject-card-container">
        <div class="subject-card-icon-and-title-container">
            <IconComponent />
            <div class="title">
                {{ props.title }}
            </div>
        </div>
        <ForwardButton :onClick="redirectToSubjectDetails"/>
    </div>
</template>

<style lang="scss" scoped>
.subject-card-container {
    display: flex;
    align-items: center;
    gap: 17px;
    border: 1px solid #D8D8D8;
    width: 380px;
    justify-content: space-between;
    padding: 12px;
    .subject-card-icon-and-title-container {
        display: flex;
        align-items: center;
        gap: 17px;
        .title {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: pre-wrap;
            flex: 1;
            color: black;
            font-weight: 400;
            font-size: 16px;
        }
    }
}
</style>