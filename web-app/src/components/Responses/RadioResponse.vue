<script setup lang="ts">
import { ref, watch } from 'vue';

const props = defineProps({
    html: {
        type: String,
        required: true,
    },
    isChecked: {
        type: Boolean,
        required: true,
    },
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

console.log('props:', props.html)
</script>

<template>
    <div class="response-container" :class="{ isCheckedResponse: isChecked }" @click="toggle">
        <div class="response-text" v-html="props.html" />
        <RadioButton :isChecked="props.isChecked" :isWrong="false"  />
    </div>
</template>

<style lang="scss" scoped>
.response-container {
    display: flex;
    justify-content: space-between;
    padding: 6px;
    border-bottom: 1px solid #D8D8D8;
    gap: 20px;
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
