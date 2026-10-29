import { Body, Controller, Post } from '@nestjs/common';
import { IsString, MinLength } from 'class-validator';
import { OtpService } from './otp.service.js';

class OtpRequestDto {
  @IsString()
  @MinLength(5)
  destination!: string;
}

class OtpVerifyDto extends OtpRequestDto {
  @IsString()
  @MinLength(4)
  code!: string;
}

@Controller('auth/otp')
export class AuthController {
  constructor(private readonly otp: OtpService) {}

  @Post('request')
  request(@Body() body: OtpRequestDto) {
    return this.otp.request(body.destination);
  }

  @Post('verify')
  verify(@Body() body: OtpVerifyDto) {
    return this.otp.verify(body.destination, body.code);
  }
}
