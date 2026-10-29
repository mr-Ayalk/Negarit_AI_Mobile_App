import { Module } from '@nestjs/common';
import { AuthController } from './auth.controller.js';
import { OtpService } from './otp.service.js';

@Module({
  controllers: [AuthController],
  providers: [OtpService],
})
export class AuthModule {}
