import { getQuestionsOfSubject } from '@/services';
import { Question } from '@/utils/types';
import { defineStore } from 'pinia';

export const useQuestionStore = defineStore("question-store", {
  state: () => ({
    questionsList: [] as Array<Question>,
    currentQuestionIndex: 0,
    isLoading: false,
    error: null as Object | any,
    score: 0,
  }),

  getters: {
    currentQuestion(state): Question {
      return state.questionsList[state.currentQuestionIndex] || null;
    },
  },

  actions: {
    async fetchQuestionsOfSubject(subjectId: string) {
      this.isLoading = true;
      this.error = null;
      this.score = 0;
      try {
        const { data, error } = await getQuestionsOfSubject(subjectId);
        if (data.questions) {
          this.questionsList = data.questions;
          this.currentQuestionIndex = 0;
        } else {
          this.error = error;
        }
      } catch (error) {
        this.error = error;
      } finally {
        this.isLoading = false;
      }
    },

    nextQuestion() {
      if (this.currentQuestionIndex < this.questionsList.length) {
        this.currentQuestionIndex++;
      }
    },

    updateScore(points: number) {
      this.score += points;
    }
  }
});
