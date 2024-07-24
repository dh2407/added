import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { join, extname } from "https://deno.land/std@0.168.0/path/mod.ts";
import { corsHeaders } from "../_shared/cors.ts";

const STATIC_DIR = join(Deno.cwd(), "swagger-ui");

async function handler(req: Request) {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  try {
    const url = new URL(req.url);
    let filePath = join(STATIC_DIR, url.pathname);
    if (url.pathname === '/') {
      filePath = join(STATIC_DIR, 'index.html');
    }

    const file = await Deno.readFile(filePath);
    const contentType = getContentType(filePath);
    return new Response(file, {
      headers: {
        "Content-Type": contentType,
        ...corsHeaders,
      },
    });
  } catch (error) {
    console.error("File not found or other error:", error);
    return new Response("Not Found", { status: 404, headers: corsHeaders });
  }
}

function getContentType(path: string): string {
  const ext = extname(path).toLowerCase();
  switch (ext) {
    case ".js":
      return "application/javascript";
    case ".css":
      return "text/css";
    case ".html":
      return "text/html";
    case ".yaml":
      return "application/x-yaml";
    default:
      return "application/octet-stream";
  }
}

serve(handler);
