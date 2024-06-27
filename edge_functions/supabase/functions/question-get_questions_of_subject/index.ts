import { createClient } from 'https://esm.sh/@supabase/supabase-js'

Deno.serve(async (_req) => {
  if (_req.method === "POST") {
    try {
      const supabase = createClient(
        Deno.env.get('SUPABASE_URL') ?? '',
        Deno.env.get('SUPABASE_ANON_KEY') ?? '',
        { global: { headers: { Authorization: _req.headers.get('Authorization')! } } }
      )

      const body = await _req.json();

      if (!body.subjectId) {
        throw new Error("subjectId is required fields.");
      }

      const { data, error } = await supabase.rpc('get_subject_with_questions_by_subject_id', { subject_id: body.subjectId });

      if (error) {
        return new Response(JSON.stringify({ message: `Error getting subject questions`, error }), {
          status: 500,
          headers: { "Content-Type": "application/json" },
        });
      }

      return new Response(JSON.stringify({ message: "Questions successfully retrieved", data: data }), {
        headers: { "Content-Type": "application/json" },
      });
    } catch (e) {
      console.error("Error parsing body:", e);
      return new Response(JSON.stringify({ error: "Invalid JSON" }), {
        status: 400,
        headers: { "Content-Type": "application/json" },
      });
    }
  } else {
    return new Response("Method not allowed", { status: 405 });
  }
})
