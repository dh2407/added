import { createClient } from 'https://esm.sh/@supabase/supabase-js'
import { corsHeaders } from '../_shared/cors.ts'

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
      const supabase = createClient(
        Deno.env.get('SUPABASE_URL') ?? '',
        Deno.env.get('SUPABASE_ANON_KEY') ?? '',
        { global: { headers: { Authorization: _req.headers.get('Authorization')! } } }
      )

      const body = await _req.json();

      if (!body.subjectId || !body.questionId || !body.label) {
        throw new Error("label, subjectId and questionId are required fields.");
      }

      const { data, error } = await supabase
        .from('QuestionToSubjectLink')
        .insert([
          { subjectId: body.subjectId, questionId: body.questionId, label: body.label },
        ])
        .select();

      if (error) {
        return new Response(JSON.stringify({ message: `Error creating parent child subject link`, error }), {
          status: 500,
          headers,
        });
      }

      return new Response(JSON.stringify({ message: "Parent Child Subject Link added successfully", data: data[0] }), {
        headers,
      });
    } catch (e) {
      console.error("Error parsing body:", e);
      return new Response(JSON.stringify({ error: "Invalid JSON" }), {
        status: 400,
        headers,
      });
    }
  } else {
    return new Response("Method not allowed", { status: 405 });
  }
})
