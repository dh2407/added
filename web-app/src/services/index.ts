import axios from 'axios'

class Api {
    private baseApiToken: string | null = null;
    
    public setBaseApiToken = (token: string) => {
        this.baseApiToken = token;
    };

    public getMainSubjects = async () => {
        try {
            const response = await axios.post(`${import.meta.env.VITE_EDGE_FUNCTIONS_BASE_URL}/subject-get_main`, {}, {
                headers: {
                    'Authorization': `Bearer ${this.baseApiToken}`,
                    'Content-Type': 'application/json',
                }
            });
            return { data: response.data.data, error: null };
        } catch (error) {
            console.error('Error fetching main subjects:', error);
            return { data: null, error }
        }
    };

    public getSubjectWithChildren = async (parentId: string) => {
        try {
            const response = await axios.post(`${import.meta.env.VITE_EDGE_FUNCTIONS_BASE_URL}/subject-get_childrens`, { parentId }, {
                headers: {
                    'Authorization': `Bearer ${this.baseApiToken}`,
                    'Content-Type': 'application/json',
                }
            });
            return { data: response.data.data, error: null };
        } catch (error) {
            console.error('Error fetching subject children:', error);
            return { data: null, error };
        }
    };

    public getQuestionsOfSubject = async (subjectId: string) => {
        try {
            const response = await axios.post(`${import.meta.env.VITE_EDGE_FUNCTIONS_BASE_URL}/question-get_questions_of_subject`, { subjectId }, {
                headers: {
                    'Authorization': `Bearer ${this.baseApiToken}`,
                    'Content-Type': 'application/json',
                }
            });
            return { data: response.data.data, error: null };
        } catch (error) {
            console.error('Error fetching questions of subject:', error);
            return { data: null, error };
        }
    };
}

export const apiService = new Api();