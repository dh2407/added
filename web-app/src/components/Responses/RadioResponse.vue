<script setup lang="ts">
import { defineProps, ref, watch, defineEmits, computed } from 'vue';

const props = defineProps({
    text: {
        type: String,
        required: true,
    },
    isChecked: {
        type: Boolean,
        required: true,
    },
    isCorrectSubmition: {
        type: Boolean,
        required: true,
    },
    isSubmitted: {
        type: Boolean,
        required: true,
    },
    isCorrectAnswer: {
        type: Boolean,
        required: true,
    }
});

const emit = defineEmits(['update:isChecked']);

const isChecked = ref(props.isChecked);

watch(() => props.isChecked, (newVal) => {
    isChecked.value = newVal;
});

const toggle = () => {
    isChecked.value = !isChecked.value;
    emit('update:isChecked', isChecked.value);
};

const addScore = computed(() => {
    return props.isSubmitted && props.isCorrectSubmition && props.isCorrectAnswer
});

const substractScore = computed(() => {
    return props.isSubmitted && !props.isCorrectSubmition
});

</script>

<template>
    <div class="response-container" :class="{ isCheckedResponse: isChecked, isCorrectAnswer: isCorrectAnswer && isSubmitted }" @click="toggle">
        <div class="response-text">
            {{ props.text }}
        </div>
        <div class="radio-button-and-score-container">
            <div v-if="addScore" class="correct score">+2</div>
            <div v-if="substractScore" class="wrong score">-1</div>
            <RadioButton :isChecked="props.isChecked" :isWrong="props.isSubmitted && !props.isCorrectSubmition"  />
        </div>
    </div>
</template>

<style lang="scss" scoped>
.response-container {
    display: flex;
    justify-content: space-between;
    padding: 6px;
    border-bottom: 1px solid #D8D8D8;
    cursor: pointer;
    .response-text {
        font-size: 16px;
        font-weight: 400;
        color: #5C656A;
    }
    .radio-button-and-score-container {
        display: flex;
        gap: 28px;
        .score {
            font-size: 23;
            font-weight: 800;
        }
        .correct {
            color: #039033;
        }
        .wrong {
            color: #C11111;
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
