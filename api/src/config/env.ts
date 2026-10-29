function present(name: string): string | undefined {
  const value = process.env[name]?.trim();
  if (!value || value.includes('change-me')) {
    return undefined;
  }
  return value;
}

export function databaseUrl(): string | undefined {
  return present('DATABASE_URL');
}

export function chapaSecret(): string | undefined {
  return present('CHAPA_SECRET_KEY');
}

export function chapaEnabled(): boolean {
  return process.env.PAYMENTS_CHAPA_ENABLED === 'true' && Boolean(chapaSecret());
}

export function mapsApiKey(): string | undefined {
  return present('GOOGLE_MAPS_API_KEY');
}
