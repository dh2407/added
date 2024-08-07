<script setup lang="ts">
import ForwardArrow from '@/assets/svgs/forward-arrow.svg'

const props = defineProps({
    onClick: {
        type: Function,
        required: true,
    },
});

</script>

<template>
    <v-btn icon outlined color="white" class="circle-btn" @click="props.onClick">
        <v-icon>
            <ForwardArrow />
        </v-icon>
    </v-btn>
</template>

<style lang="scss" scoped></style>