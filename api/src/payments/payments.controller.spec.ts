import { ServiceUnavailableException } from '@nestjs/common';
import { Test } from '@nestjs/testing';
import { ChapaService } from './chapa.service.js';
import { PaymentsController } from './payments.controller.js';

describe('PaymentsController', () => {
  it('keeps Chapa unavailable until a secret is configured', async () => {
    const module = await Test.createTestingModule({
      controllers: [PaymentsController],
      providers: [ChapaService],
    }).compile();
    const controller = module.get(PaymentsController);

    await expect(
      controller.chapaSession({
        amount: 10,
        email: 'visitor@example.com',
        txRef: 'test-ref',
      }),
    ).rejects.toBeInstanceOf(ServiceUnavailableException);
  });

  it('labels Telebirr as demo', () => {
    const controller = new PaymentsController(new ChapaService());
    expect(controller.telebirrSession()).toEqual({
      mode: 'demo',
      provider: 'telebirr',
      message: 'Telebirr is not configured. Reserve or pay at the shop.',
    });
  });
});
