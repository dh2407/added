import { createClient } from 'https://esm.sh/@supabase/supabase-js'
import { corsHeaders } from '../_shared/cors.ts'
import type { SectionGetNextSectionPost200Response } from '../../../../generated-api/index.ts'

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
      const { subject_id } = await _req.json();
      if (!subject_id) {
        return new Response(JSON.stringify({ error: "Missing subject_id in request" }), {
          status: 400,
          headers,
        });
      }

      const supabase = createClient(
        Deno.env.get('SUPABASE_URL') ?? '',
        Deno.env.get('SUPABASE_ANON_KEY') ?? '',
        { global: { headers: { Authorization: _req.headers.get('Authorization')! } } }
      )

      const { data, error } = await supabase
        .from('Section')
        .select('*')
        .eq('subject_id', subject_id)
        .order('order', { ascending: true })
        .limit(1)
        .single();

      const { count: totalCount, error: totalCountError } = await supabase
        .from('Section')
        .select('id', { count: 'exact' })
        .eq('subject_id', subject_id)

      if (totalCountError) {
        return new Response(JSON.stringify({ message: `Error getting total sections count`, error: totalCountError.message }), {
          status: 500,
          headers,
        });
      }

      if (error) {
        return new Response(JSON.stringify({ message: `Error getting first section`, error: error.message }), {
          status: 500,
          headers,
        });
      }

      // Type assertion to ensure data fits the expected type
      const responseData: SectionGetNextSectionPost200Response = {
        kind: data.kind,
        scenes: data.scenes,
        section_id: data.id,
        is_last: data.order === totalCount
      };

      return new Response(JSON.stringify({ message: "First section successfully retrieved", data: responseData }), {
        headers,
      });
    } catch (e) {
      console.error("Error processing request:", e);
      return new Response(JSON.stringify({ error: "Invalid JSON" }), {
        status: 400,
        headers,
      });
    }
  } else {
    return new Response("Method not allowed", { status: 405 });
  }
})
