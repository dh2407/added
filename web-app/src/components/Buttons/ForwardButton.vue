<script setup lang="ts">
import ForwardIcon from '@/assets/svgs/forward-icon.svg'

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
            <ForwardIcon />
        </v-icon>
    </v-btn>
</template>

<style lang="scss" scoped></style>