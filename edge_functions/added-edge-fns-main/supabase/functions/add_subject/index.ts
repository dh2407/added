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

      if (!body.title || !body.description) {
        throw new Error("title and description are required fields.");
      }

      const { data, error } = await supabase
      .from('Subject')
      .insert([
        { title: body.title, description: body.description },
      ])
      .select()
      
      if (error) {
        return new Response(JSON.stringify({ message: "Error inserting subject", error }), {
          status: 500,
          headers: { "Content-Type": "application/json" },
        });
      }
      
      return new Response(JSON.stringify({ message: "Subject added successfully", data }), {
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