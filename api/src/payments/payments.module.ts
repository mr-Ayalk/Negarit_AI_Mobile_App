import { Module } from '@nestjs/common';
import { ChapaService } from './chapa.service.js';
import { PaymentsController } from './payments.controller.js';

@Module({
  controllers: [PaymentsController],
  providers: [ChapaService],
})
export class PaymentsModule {}
