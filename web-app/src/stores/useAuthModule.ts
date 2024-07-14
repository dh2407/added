import { router } from '@/router';
import { apiService } from '@/services';
import { authService } from '@/services/authService';
import { defineStore } from 'pinia';

export const useAuthStore = defineStore("auth-store", {
  state: () => ({
    currentUser: null as any,
    accessToken: null as string | null,
    refreshToken: null as string | null,
    isLoggedIn: false as boolean,
    isLoading: false,
    error: null as Object | any,
  }),

  getters: {},

  actions: {
    async signUp(email: string, password: string): Promise<boolean> {
      this.isLoading = true;
      this.error = null;
      try {
        const { data, error } = await authService.signUp(email, password);
        if (data) {
          return true;
        } else {
          this.error = error;
          return false;
        }
      } catch (error) {
        this.error = error;
        return false;
      } finally {
        this.isLoading = false;
      }
    },
    async signIn(email: string, password: string) {
      this.isLoading = true;
      this.error = null;
      try {
        const { data, error } = await authService.signInWithEmail(email, password);
        if (data && data.user && data.session) {
          await this.setCurrentUser(data.session)
          router.push({
            name: 'Home'
          })
        } else {
          this.error = error;
          this.currentUser = null
          this.accessToken = null
          this.refreshToken = null
          this.isLoggedIn = false
          return false;
        }
      } catch (error) {
        this.error = error;
        return false;
      } finally {
        this.isLoading = false;
      }
    },
    async getCurrent() {
      const { session } = await authService.getCurrent();
      await this.setCurrentUser(session)
      return session?.user
    },
    async setCurrentUser(session: any) {
      if (session) {
        this.currentUser = session.user
        this.accessToken = session.access_token
        this.refreshToken = session.refresh_token
        this.isLoggedIn = true
        apiService.setBaseApiToken(session.access_token)
      } else {
        this.currentUser = null;
        this.accessToken = "";
        this.refreshToken = "";
        apiService.setBaseApiToken("")
      }
    },
  }
});
