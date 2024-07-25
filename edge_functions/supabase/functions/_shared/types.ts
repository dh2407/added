// WIP
export interface ErrorInfo {
    error: any;
    message: string;
}

export interface ApiResponse {
    data: any;
    error: ErrorInfo | null;
    message: string;
}