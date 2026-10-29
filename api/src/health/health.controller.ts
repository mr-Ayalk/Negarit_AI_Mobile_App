import { Controller, Get } from '@nestjs/common';
import { chapaEnabled, databaseUrl, mapsApiKey } from '../config/env.js';

@Controller('health')
export class HealthController {
  @Get()
  check() {
    return {
      status: 'ok' as const,
      database: databaseUrl() ? 'configured' : 'not-configured',
      chapa: chapaEnabled() ? 'configured' : 'demo',
      telebirr: 'demo' as const,
      ai: 'mock' as const,
      maps: mapsApiKey() ? 'configured' : 'floorplan',
    };
  }
}
