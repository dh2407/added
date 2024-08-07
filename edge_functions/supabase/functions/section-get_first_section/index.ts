import type { SectionResponse } from "../../../../generated-api/index.ts";
import { corsHeaders } from '../_shared/cors.ts'
import { createApiResponse, methodNotAllowedResponse } from "../_shared/helper.ts";
import { SectionService } from './../domain/section/service.ts'
import { PgSectionRepository } from './../infra/repository/pg_section_repository.ts'

Deno.serve(async (_req) => {
  if (_req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  if (_req.method === "POST") {
    try {
      const { subject_id } = await _req.json();

      if (!subject_id) {
        return createApiResponse({
          data: null,
          error: "Missing subject_id in request",
          message: "Invalid request"
        });
      }

      const sectionService = new SectionService(new PgSectionRepository);

      const data: SectionResponse = await sectionService.getFirstSection(subject_id);

      return createApiResponse({
        data,
        error: null,
        message: "Success"
      });

    } catch (err) {
      return createApiResponse({
        data: null,
        error: err,
        message: "Error processing request"
      });
    }
  } else {
    return methodNotAllowedResponse();
  }
})
