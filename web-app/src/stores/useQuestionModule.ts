import { getQuestionsOfSubject } from '@/services';
import { MultipleChoiceQuestion, Question } from '@/utils/types';
import { defineStore } from 'pinia';

export const useQuestionStore = defineStore("question-store", {
  state: () => {
    return {
      questionsList: [] as Array<Question | MultipleChoiceQuestion >,
      question: null as Question | MultipleChoiceQuestion | null,
      isLoading: false,
      error: null as Object | any,
    };
  },

  getters: {},

  actions: {
    async fetchQuestionsOfSubject(subjectId: string) {
      this.isLoading = true;
      this.error = null;
      try {
        const { data, error } = await getQuestionsOfSubject(subjectId);
        if (data.questions) this.questionsList = data.questions;
        else this.error = error
      } catch (error) {
        this.error = error;
      } finally {
        this.isLoading = false;
      }
    },
  }
});
