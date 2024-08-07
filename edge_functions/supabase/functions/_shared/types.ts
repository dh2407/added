export interface ApiResponse {
    data: any;
    error: any;
    message: string;
}

export class ErrorInfo extends Error {
    error: string;
    message: string;

    constructor(error: string, message: string) {
        super(message);
        this.error = error;
        this.message = message;
    }
}
