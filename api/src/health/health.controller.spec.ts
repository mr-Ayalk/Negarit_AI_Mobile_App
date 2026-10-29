import { Test, TestingModule } from '@nestjs/testing';
import { HealthController } from './health.controller.js';

describe('HealthController', () => {
  let controller: HealthController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [HealthController],
    }).compile();

    controller = module.get(HealthController);
  });

  it('reports ok and keeps missing providers labeled', () => {
    const body = controller.check();
    expect(body.status).toBe('ok');
    expect(body.telebirr).toBe('demo');
    expect(body.ai).toBe('mock');
    expect(['configured', 'not-configured']).toContain(body.database);
    expect(['configured', 'demo']).toContain(body.chapa);
    expect(['configured', 'floorplan']).toContain(body.maps);
  });
});
