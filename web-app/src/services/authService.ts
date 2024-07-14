import axios from 'axios'
import { supabase } from './supabaseService';

export class AuthService {
    async getCurrent() {
        let { data, error } = await supabase.auth.getSession();
        await supabase.auth.onAuthStateChange((event: any, session: any) => {
            if (event == "SIGNED_OUT" || !data.session) {
                data.session = null;
            } else {
                data = session;
            }
        });
        return { session: data.session, error: error };
    }

    async signInWithEmail(email: string, password: string) {
        const { data, error } = await supabase.auth.signInWithPassword({
            email,
            password
        });
        return { data, error }
        // if (result.error) {
        //     Components.ElMessage.error(result.error);
        // }
    }

    // async setAuth() {
    //     const token = localStorage.getItem("supabase.auth.token");
    //     return await supabase.auth.setAuth(JSON.parse(token!).currentSession.access_token);
    // }

    async signUp(email: string, password: string) {
        try {
            const response = await axios.post(`${import.meta.env.VITE_EDGE_FUNCTIONS_BASE_URL}/auth-sign_up`, { email, password }, {
                headers: {
                    'Authorization': `Bearer ${import.meta.env.VITE_SERVICE_ROLE_KEY}`,
                    'Content-Type': 'application/json',
                }
            });
            return { data: response.data.data, error: null };
        } catch (error) {
            console.error('Error fetching main subjects:', error);
            return { data: null, error }
        }
    }

    async signOut() {
        const { error } = await supabase.auth.signOut();
        // router.push({ name: "sign-in" });
    }
    tryParseJson = (jsonString: any) => {
        try {
            let parsed = JSON.parse(jsonString);
            return parsed;
        } catch (error) {
            return undefined;
        }
    };
    getParameterByName(name: string, url?: string) {
        if (typeof window === "undefined") return "";

        if (!url) url = window?.location?.href || "";
        name = name.replace(/[\[\]]/g, "\\$&");
        const regex = new RegExp("[?&#]" + name + "(=([^&#]*)|&|#|$)"),
            results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return "";
        return decodeURIComponent(results[2].replace(/\+/g, " "));
    }
    getAccessToken() {
        const tokenData = localStorage.getItem("supabase.auth.token");
        if (!tokenData) {
            const access_token = this.getParameterByName("access_token");
            if (access_token) return access_token;
            else return undefined;
        }
        const tokenObj = this.tryParseJson(tokenData);
        if (tokenObj === false) {
            return "";
        }
        return tokenObj.currentSession.access_token;
    }
}

export const authService = new AuthService();

