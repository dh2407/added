import { defineStore } from 'pinia';
import { getMainSubjects, getSubjectWithChildren } from '@/services';
import { Subject, SubjectWithChildren, SubSubject } from '@/utils/types';

export const useSubjectStore = defineStore("subject-store", {
  state: () => {
    return {
      subjectList: [] as Array<Subject>,
      subject: null as Subject | SubjectWithChildren | SubSubject | null,
      isLoading: false,
      error: null as Object | any,
    };
  },

  getters: {},

  actions: {
    async fetchMainSubjects() {
      this.isLoading = true;
      this.error = null;
      try {
        const { data, error } = await getMainSubjects();
        if (data) this.subjectList = data;
        else this.error = error
      } catch (error) {
        this.error = error;
      } finally {
        this.isLoading = false;
      }
    },
    async fetchSubjectWithChildren(parentId: string) {
      this.isLoading = true;
      this.error = null;
      try {
        const { data, error } = await getSubjectWithChildren(parentId);
        if (data) this.subject = data;
        else this.error = error
      } catch (error) {
        this.error = error;
      } finally {
        this.isLoading = false;
      }
    }
  }
});
