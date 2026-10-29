import { Injectable, Logger, UnauthorizedException } from '@nestjs/common';

const fiveMinutes = 5 * 60 * 1000;

type Challenge = {
  code: string;
  expiresAt: number;
};

@Injectable()
export class OtpService {
  private readonly logger = new Logger(OtpService.name);
  private readonly challenges = new Map<string, Challenge>();
  createCode: () => string = () =>
    (100000 + Math.floor(Math.random() * 900000)).toString();

  request(destination: string) {
    const code = this.createCode();
    this.challenges.set(destination.trim(), {
      code,
      expiresAt: Date.now() + fiveMinutes,
    });
    this.logger.log(`OTP for ${destination.trim()}: ${code}`);
    return {
      delivery: 'log' as const,
      message: 'The sign-in code is printed in the API log.',
    };
  }

  verify(destination: string, code: string) {
    const challenge = this.challenges.get(destination.trim());
    const matches =
      challenge !== undefined &&
      challenge.expiresAt >= Date.now() &&
      challenge.code === code.trim();
    if (!matches) {
      throw new UnauthorizedException('That code is not valid.');
    }
    this.challenges.delete(destination.trim());
    return {
      signedIn: true as const,
      destination: destination.trim(),
    };
  }
}
