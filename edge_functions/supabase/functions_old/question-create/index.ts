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

      if (!body.type || !body.props) {
        throw new Error("type and props are required fields.");
      }

      const { data, error } = await supabase
      .from('Question')
      .insert([
        { type: body.type, props: body.props },
      ])
      .select()
      
      if (error) {
        return new Response(JSON.stringify({ message: "Error creating question", error }), {
          status: 500,
          headers: { "Content-Type": "application/json" },
        });
      }
      
      return new Response(JSON.stringify({ message: "Question created successfully", data }), {
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