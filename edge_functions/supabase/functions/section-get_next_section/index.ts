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
      const { section_id } = await _req.json();

      if (!section_id) {
        return new Response(JSON.stringify({ error: "Missing section_id in request" }), {
          status: 400,
          headers,
        });
      }

      const supabase = createClient(
        Deno.env.get('SUPABASE_URL') ?? '',
        Deno.env.get('SUPABASE_ANON_KEY') ?? '',
        { global: { headers: { Authorization: _req.headers.get('Authorization')! } } }
      )

      // can fix this by getting subject_id and order
      // so we will retrive the section that have that subject_id and the order next to the order in params

      const { data: sectionData, error: sectionError } = await supabase
        .from('Section')
        .select('*')
        .eq('id', section_id)
        .single();

      console.log('sectionData:', sectionData)

      if (sectionData === null) {
        return new Response(JSON.stringify({ message: `Error getting next section`, error: sectionError?.message }), {
          status: 500,
          headers,
        });
      }

      // const { data: nextSection, error: nextSectionError } = await supabase
      //   .from('Section')
      //   .select('*')
      //   .eq('subject_id', sectionData.subject_id)
      //   .eq('order', Number(sectionData.order+1))
      //   .limit(1)
      //   .single();

      // WIP: FIX THIS AFTER CHOOSING RPC OR DB CONNECTION INSTEAD OF THE SUPABASE CLIENT
      const { data: nextSection, error: nextSectionError } = await supabase.from("Section").query(`
      SELECT * FROM "Section"
      WHERE subject_id = ${sectionData.subject_id} AND "order" = ${sectionData.order + 1}`)

      console.log('nextSection:', nextSection)

      if (nextSectionError) {
        return new Response(JSON.stringify({ message: `Error getting next section`, error: nextSectionError.message }), {
          status: 500,
          headers,
        });
      }

      const { count: totalCount, error: totalCountError } = await supabase
        .from('Section')
        .select('id', { count: 'exact' })
        .eq('subject_id', nextSection.subject_id)

      console.log('nextSection:', totalCount)

      if (totalCountError) {
        return new Response(JSON.stringify({ message: `Error getting total sections count`, error: totalCountError.message }), {
          status: 500,
          headers,
        });
      }


      const responseData: SectionGetNextSectionPost200Response = {
        kind: nextSection.kind,
        scenes: nextSection.scenes,
        section_id: nextSection.id,
        is_last: nextSection.order === totalCount
      };
      return new Response(JSON.stringify({ message: "Next section successfully retrieved", data: responseData }), {
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
