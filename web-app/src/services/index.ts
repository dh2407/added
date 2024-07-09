import axios from 'axios'

const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9ldWVweGJ4aXNiYW5rY3huY2hvIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcxOTA3NzcyMCwiZXhwIjoyMDM0NjUzNzIwfQ.-M84pQwjkBbUifSdM380PYJ29F73xl3L0wRFAfCh4ws';

export const getMainSubjects = async () => {
    const url = 'https://oeuepxbxisbankcxncho.supabase.co/functions/v1/subject-get_main';

    try {
        const response = await axios.post(url, {}, {
            headers: {
                'Authorization': `Bearer ${token}`,
                'Content-Type': 'application/json',
            }
        });
        return { data: response.data.data, error: null };
    } catch (error) {
        console.error('Error fetching main subjects:', error);
        return { data: null, error }
    }
};

export const getSubjectWithChildren = async (parentId: string) => {
    const url = 'https://oeuepxbxisbankcxncho.supabase.co/functions/v1/subject-get_childrens';

    try {
        const response = await axios.post(url, { parentId }, {
            headers: {
                'Authorization': `Bearer ${token}`,
                'Content-Type': 'application/json',
            }
        });
        return { data: response.data.data, error: null };
    } catch (error) {
        console.error('Error fetching subject children:', error);
        return { data: null, error };
    }
};

export const getQuestionsOfSubject = async (subjectId: string) => {
    const url = 'https://oeuepxbxisbankcxncho.supabase.co/functions/v1/question-get_questions_of_subject';

    try {
        const response = await axios.post(url, { subjectId }, {
            headers: {
                'Authorization': `Bearer ${token}`,
                'Content-Type': 'application/json',
            }
        });
        return { data: response.data.data, error: null };
    } catch (error) {
        console.error('Error fetching questions of subject:', error);
        return { data: null, error };
    }
};

