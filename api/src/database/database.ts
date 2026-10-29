import pg from 'pg';
import { databaseUrl } from '../config/env.js';

let pool: pg.Pool | undefined;

export function getPool(): pg.Pool {
  const connectionString = databaseUrl();
  if (!connectionString) {
    throw new Error('DATABASE_URL is not configured.');
  }
  pool ??= new pg.Pool({ connectionString });
  return pool;
}

export async function query<T extends pg.QueryResultRow>(
  text: string,
  values: unknown[] = [],
): Promise<pg.QueryResult<T>> {
  return getPool().query<T>(text, values);
}
