import { Module } from '@nestjs/common';
import { GuideController } from './guide.controller.js';

/** Mock guide. It classifies the visit list and does not call a model. */
@Module({
  controllers: [GuideController],
})
export class AiModule {}
