import { corsHeaders } from "./cors.ts";
import { ApiResponse } from "./types.ts";

const jsonHeaders = {
    "Access-Control-Allow-Methods": "POST",
    "Access-Control-Expose-Headers": "Content-Length, X-JSON",
    "Content-Type": "application/json; charset=utf-8",
    ...corsHeaders,
  }

export const createApiResponse = (response: ApiResponse, headers?: Headers): Response => {
    const status = response.error ? 400 : 200;
    return new Response(JSON.stringify(response), {
        status,
        headers: headers ?? jsonHeaders,
    });
}

export const methodNotAllowedResponse = (message?: string): Response => {
    return new Response(message ?? "Method not allowed", { status: 405 });
}
