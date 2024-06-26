import { createClient } from 'https://esm.sh/@supabase/supabase-js'

Deno.serve(async (_req) => {
  if (_req.method === "POST") {
    try {
      const supabase = createClient(
        Deno.env.get('SUPABASE_URL') ?? '',
        Deno.env.get('SUPABASE_ANON_KEY') ?? '',
        { global: { headers: { Authorization: _req.headers.get('Authorization')! } } }
      )

      const { data, error } = await supabase.rpc('get_subjects_with_children');

      if (error) {
        return new Response(JSON.stringify({ message: `Error getting subjects`, error }), {
          status: 500,
          headers: { "Content-Type": "application/json" },
        });
      }

      return new Response(JSON.stringify({ message: "Subjects successfully retrieved", data: data }), {
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
