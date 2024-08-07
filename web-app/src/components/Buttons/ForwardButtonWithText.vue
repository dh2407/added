<script setup lang="ts">
import ForwardArrow from '@/assets/svgs/forward-arrow.svg'

const props = defineProps({
    text: {
        type: String,
        required: true,
    },
    onClick: {
        type: Function,
        required: true,
    },
});

</script>

<template>
        <!-- <v-btn icon outlined color="white"  @click="props.onClick">
            <div></div>
            <v-icon>
                <ForwardArrow />
            </v-icon>
        </v-btn> -->
        <v-btn rounded="xl" @click="props.onClick" >
            <div class="forward-btn-with-text-container" >
                <span class="text">{{props.text}}</span>
                <ForwardArrow />
            </div>
        </v-btn>
</template>

<style lang="scss" scoped>
.forward-btn-with-text-container {
    display: flex;
    gap: 20px;
    align-items: center;
    .text {
        color: #4A71D2; 
        font-size: 14px;
        font-weight: 400;
    }
}
</style>