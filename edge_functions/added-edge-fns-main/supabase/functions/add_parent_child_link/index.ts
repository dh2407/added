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

      if (!body.parentId || !body.childId || !body.label) {
        throw new Error("label, parentId and childId are required fields.");
      }

      const { data, error } = await supabase
        .from('ParentChildSubjectsLink')
        .insert([
          { parentId: body.parentId, childId: body.childId, label: body.label },
        ])
        .select();

      if (error) {
        return new Response(JSON.stringify({ message: `Error creating parent child subject link`, error }), {
          status: 500,
          headers: { "Content-Type": "application/json" },
        });
      }

      return new Response(JSON.stringify({ message: "Parent Child Subject Link added successfully", data: data[0] }), {
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
