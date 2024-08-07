<script setup lang="ts">
import InfoSvg from '@/assets/svgs/info-icon.svg'
import { PropType } from 'vue';

const props = defineProps({
    isActive: {
        type: Boolean,
        required: true,
    },
    onClick: {
        type: Function as PropType<() => void>,
        required: true,
    },
});

const handleClick = (event: MouseEvent) => {
    event.stopPropagation();
    props.onClick();
}

</script>

<template>
    <div :class="{ 'active-button': isActive, 'inactive-button': !isActive }" @click="handleClick" class="icon-button">
        <InfoSvg alt="info icon" />
    </div>
</template>


<style scoped>
.icon-button {
    border: 2px solid #FF7F50;
    border-radius: 50%;
    background-color: #fff;
    color: #FF7F50;
    width: 40px;
    height: 40px;
    display: flex;
    justify-content: center;
    align-items: center;
    cursor: pointer;
    transition: box-shadow 0.3s ease;
}

.active-button {
    box-shadow: none;
}

.inactive-button {
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}
</style>