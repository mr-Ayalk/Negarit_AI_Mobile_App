import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication } from '@nestjs/common';
import request from 'supertest';
import { App } from 'supertest/types.js';
import { AppModule } from './../src/app.module.js';

describe('AppController (e2e)', () => {
  let app: INestApplication<App>;

  beforeEach(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    await app.init();
  });

  it('/ (GET)', () => {
    return request(app.getHttpServer())
      .get('/')
      .expect(200)
      .expect('Hello World!');
  });

  it('/health (GET)', () => {
    return request(app.getHttpServer())
      .get('/health')
      .expect(200)
      .expect((response) => {
        expect(response.body.status).toBe('ok');
        expect(response.body.telebirr).toBe('demo');
        expect(response.body.ai).toBe('mock');
      });
  });

  it('/payments/chapa/session (POST) stays unavailable without a secret', () => {
    return request(app.getHttpServer())
      .post('/payments/chapa/session')
      .send({ amount: 10, email: 'visitor@example.com', txRef: 'test-ref' })
      .expect(503);
  });

  it('/payments/telebirr/session (POST) is a labeled demo', () => {
    return request(app.getHttpServer())
      .post('/payments/telebirr/session')
      .expect(201)
      .expect({
        mode: 'demo',
        provider: 'telebirr',
        message: 'Telebirr is not configured. Reserve or pay at the shop.',
      });
  });

  it('/venues (GET) returns the unverified Adwa placeholder', () => {
    return request(app.getHttpServer())
      .get('/venues')
      .expect(200)
      .expect((response) => {
        expect(response.body).toMatchObject({
          source: 'placeholder-seed',
          verified: false,
        });
        expect(response.body.venues[0].slug).toBe('adwa-museum');
      });
  });

  afterEach(async () => {
    await app.close();
  });
});
