import type { SectionResponse } from "../../../../generated-api/index.ts";
import { corsHeaders } from '../_shared/cors.ts'
import { SectionService } from './../domain/section/service.ts'
import { PgSectionRepository } from './../infra/repository/pg_section_repository.ts'

const headers = {
  "Access-Control-Allow-Methods": "POST",
  "Access-Control-Expose-Headers": "Content-Length, X-JSON",
  "Content-Type": "application/json",
  ...corsHeaders,
}

Deno.serve(async (_req) => {
  if (_req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  if (_req.method === "POST") {
    try {
      const headers = new Headers({
        'Content-Type': 'application/json; charset=utf-8'
      });

      const { section_id } = await _req.json();
      if (!section_id) {
        return new Response(JSON.stringify({ error: "Missing section_id in request" }), {
          status: 400,
          headers,
        });
      }

      const sectionService = new SectionService(new PgSectionRepository);

      const responseData: SectionResponse | null = await sectionService.getNextSection(section_id);
      if (responseData === null) {
        return new Response(JSON.stringify({ error: "Error getting next section" }), {
          status: 400,
          headers,
        });
      }

      return new Response(JSON.stringify({ message: "Next section successfully retrieved", data: responseData }), {
        headers,
      });
    } catch (err) {
      console.error("Error processing request:", err);
      return new Response(JSON.stringify({ message: "Invalid JSON", error: err }), {
        status: 400,
        headers,
      });
    }
  } else {
    return new Response("Method not allowed", { status: 405 });
  }
})
