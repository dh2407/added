<script setup lang="ts">
import CrossSvg from '@/assets/svgs/cross-icon.svg'

const props = defineProps({
    isChecked: {
        type: Boolean,
        required: true,
    },
    isWrong: {
        type: Boolean,
        required: true,
    }
});

</script>

<template>
    <div class="radio-button-container" :class="{ isCheckedRadio: props.isChecked }">
        <div v-if="props.isWrong" class="radio-button-cross-container" >
            <CrossSvg />
        </div>
    </div>
</template>

<style lang="scss" scoped>
.radio-button-container {
    width: 40px;
    height: 40px;
    border: 1px solid #4A71D2;
    border-radius: 50%;
    cursor: pointer;
    position: relative;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
    flex-grow: 0;
    box-sizing: border-box;
    .radio-button-cross-container {
        position: absolute;
        display: flex;
    }
}
.isCheckedRadio {
    background-color: #4A71D2;
}
</style>
