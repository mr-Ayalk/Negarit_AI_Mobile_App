import { readFileSync, existsSync } from 'node:fs';
import { resolve } from 'node:path';
import pg from 'pg';

const root = resolve(import.meta.dirname, '../..');

function readEnvFile(file) {
  if (!existsSync(file)) {
    return {};
  }
  const values = {};
  for (const line of readFileSync(file, 'utf8').split(/\r?\n/)) {
    const trimmed = line.trim();
    if (!trimmed || trimmed.startsWith('#')) {
      continue;
    }
    const eq = trimmed.indexOf('=');
    if (eq < 1) {
      continue;
    }
    let value = trimmed.slice(eq + 1).trim();
    if (
      (value.startsWith('"') && value.endsWith('"')) ||
      (value.startsWith("'") && value.endsWith("'"))
    ) {
      value = value.slice(1, -1);
    }
    values[trimmed.slice(0, eq).trim()] = value;
  }
  return values;
}

function redact(error) {
  return String(error?.message ?? error)
    .replace(/postgres(?:ql)?:\/\/\S+/gi, 'postgresql://***')
    .replace(/password[=:]\S+/gi, 'password=***');
}

const fileEnv = readEnvFile(resolve(root, '.env'));
const connectionString = (
  fileEnv.DATABASE_URL || process.env.DATABASE_URL
)?.trim();
if (!connectionString || connectionString.includes('change-me')) {
  console.error(
    'Set DATABASE_URL in the gitignored .env file, then run this script again.',
  );
  process.exit(1);
}

const local = /@(localhost|127\.0\.0\.1)(:|\/)/.test(connectionString);
const client = new pg.Client({
  connectionString,
  ssl: local ? undefined : { rejectUnauthorized: false },
});

async function runFile(file, optional) {
  const sql = readFileSync(file, 'utf8');
  try {
    await client.query(sql);
    console.log(`applied ${file.slice(root.length + 1)}`);
  } catch (error) {
    if (optional) {
      console.error(`skipped ${file.slice(root.length + 1)}: ${redact(error)}`);
      return;
    }
    throw error;
  }
}

try {
  await client.connect();
  await runFile(resolve(root, 'infra/postgres/enable-extensions.sql'), true);
  await runFile(resolve(root, 'infra/postgres/migrations/001_core.sql'), false);
  await runFile(resolve(root, 'infra/postgres/seed/001_adwa.sql'), false);
  console.log('Adwa placeholder seed applied');
} catch (error) {
  console.error(redact(error));
  process.exitCode = 1;
} finally {
  await client.end().catch(() => undefined);
}
