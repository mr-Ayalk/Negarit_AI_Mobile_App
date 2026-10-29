import {
  Body,
  Controller,
  Post,
  ServiceUnavailableException,
} from '@nestjs/common';
import { IsEmail, IsNumber, IsOptional, IsString, Min } from 'class-validator';
import { chapaEnabled } from '../config/env.js';
import { ChapaService } from './chapa.service.js';

class ChapaSessionDto {
  @IsNumber()
  @Min(1)
  amount!: number;

  @IsEmail()
  email!: string;

  @IsString()
  txRef!: string;

  @IsOptional()
  @IsString()
  firstName?: string;

  @IsOptional()
  @IsString()
  lastName?: string;
}

@Controller('payments')
export class PaymentsController {
  constructor(private readonly chapa: ChapaService) {}

  @Post('chapa/session')
  async chapaSession(@Body() body: ChapaSessionDto) {
    if (!chapaEnabled()) {
      throw new ServiceUnavailableException(
        'Chapa is not configured. Reserve or pay at the shop.',
      );
    }
    return this.chapa.createSession(body);
  }

  @Post('telebirr/session')
  telebirrSession() {
    return {
      mode: 'demo' as const,
      provider: 'telebirr',
      message: 'Telebirr is not configured. Reserve or pay at the shop.',
    };
  }
}
