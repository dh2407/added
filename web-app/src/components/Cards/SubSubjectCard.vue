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
	subSubjectId: {
		type: Number,
		required: true,
	},
});

const IconComponent = ref(markRaw(props.icon))

const redirectToSubjectDetails = () => {
	if (props.subSubjectId && props.subjectId) {
		router.push({
			name: 'SubSubjectView',
			params: { 
				subSubjectId: props.subSubjectId,
				subjectId: props.subjectId,
			}
		});
	} else {
		console.error('Subject ID is required to navigate to SubjectDetailsView.');
	}
}
</script>



<template>
	<div class="sub-subject-card-container">
		<div class="sub-subject-card-icon-and-title-container">
			<IconComponent />
			<div class="title">
				{{ props.title }}
			</div>
		</div>
		<ForwardButton :onClick="redirectToSubjectDetails" />
	</div>
</template>

<style lang="scss" scoped>
.sub-subject-card-container {
	display: flex;
	align-items: center;
	gap: 17px;
	border-bottom: 1px solid #D8D8D8;
	justify-content: space-between;
	padding: 12px;

	.sub-subject-card-icon-and-title-container {
		display: flex;
		align-items: center;
		gap: 17px;

		.title {
			overflow: hidden;
			text-overflow: ellipsis;
			white-space: pre-wrap;
			flex: 1;
			color: #5C656A;
			font-size: 16px;
			font-weight: 400;
		}
	}

}
</style>
