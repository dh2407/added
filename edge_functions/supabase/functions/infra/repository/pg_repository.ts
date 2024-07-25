import * as postgres from 'https://deno.land/x/postgres@v0.17.0/mod.ts'

export const getPostgresPool = () => {
    const databaseUrl = Deno.env.get('SUPABASE_DB_URL')!
    const pool = new postgres.Pool(databaseUrl, 3, true)
    return pool
}