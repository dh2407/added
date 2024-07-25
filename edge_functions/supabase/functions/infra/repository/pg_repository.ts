import * as postgres from '@postgres';

export const getPostgresPool = () => {
    const databaseUrl = Deno.env.get('SUPABASE_DB_URL')!
    const pool = new postgres.Pool(databaseUrl, 3, true)
    return pool
}