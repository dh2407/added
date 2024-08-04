<script setup lang="ts">
import { PropType, reactive } from 'vue';
import { QuestionResponse } from "@/views/Section/QuestionsGameSection/QuestionsGameSection";
import { onMounted } from 'vue';
import { RadioResponse } from './RadioResponse';

const state = reactive({
  instance: null as RadioResponse | null,
});

const props = defineProps({
    response: {
        type: Object as PropType<QuestionResponse>,
        required: true,
    },
    showExplanations: {
        type: Boolean,
        required: true,
    },
    onToggle: {
        type: Function as PropType<(responseId: string, newVal: boolean) => void>,
        required: true,
    },
    onExplanationClicked: {
        type: Function as PropType<(responseId: string) => void>,
        required: true,
    },
});

onMounted(() => {
    state.instance = new RadioResponse(props.response, props.showExplanations, props.onToggle, props.onExplanationClicked)
})

</script>

<template>
    <div v-if="state.instance">
        <div class="response-container" :class="{ isCheckedResponse: state.instance.isChecked }" @click="state.instance.toggle">
            <div class="response-content-container">
                <div class="response-text" v-html="state.instance.html" />
                <div class="response-radio-btn-and-explanation-container">
                    <InfoButton v-if="state.instance.showExplanationButton" :isActive="state.instance.isExplanationOpen" :onClick="state.instance.handleExplanationClicked.bind(state.instance)" />
                    <RadioButton :isChecked="state.instance.isChecked" :isWrong="false"  />
                </div>
            </div>
            <div class="explanation-container" v-if="state.instance.isExplanationOpen">
                <div class="explanation-score" :style="{ color: state.instance.selectedScoreColor}">{{ state.instance.selectedScore?.toString() }}</div>
                <div class="explanation-content">{{ state.instance.explanation }}</div>
            </div>
        </div>
    </div>
</template>

<style lang="scss" scoped>
.response-container {
    display: flex;
    flex-direction: column;
    padding: 6px;
    border-bottom: 1px solid #D8D8D8;
    cursor: pointer;
    .response-content-container {
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        align-items: center;
        .response-text {
            font-size: 16px;
            font-weight: 400;
            color: #5C656A;
        }
        .response-radio-btn-and-explanation-container {
            display: flex;
            gap: 10px;
            align-items: center;
        }
    }
    .explanation-container {
        display: flex;
        gap: 10px;
        padding: 10px;
        .explanation-content {
            color: #ED7853;
            font-size: 16px;
            font-weight: 400;
        }
        .explanation-score {
            font-size: 24;
            font-weight: 800;
        }
    }
}
.isCheckedResponse {
    background-color: #F8F9FD;
}
.isCorrectAnswer {
    border: 1px solid #4A71D2;
}
</style>
