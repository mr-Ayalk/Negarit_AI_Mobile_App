import { UnauthorizedException } from '@nestjs/common';
import { OtpService } from './otp.service.js';

describe('OtpService', () => {
  it('accepts the code it prints and does not return that code', () => {
    const service = new OtpService();
    service.createCode = () => '246810';
    const messages: string[] = [];
    jestLikeLog(service, messages);

    const response = service.request('visitor@example.com');

    expect(response).toEqual({
      delivery: 'log',
      message: 'The sign-in code is printed in the API log.',
    });
    expect(JSON.stringify(response)).not.toContain('246810');
    expect(messages.join('\n')).toContain('OTP for visitor@example.com: 246810');
    expect(service.verify('visitor@example.com', '246810')).toEqual({
      signedIn: true,
      destination: 'visitor@example.com',
    });
  });

  it('rejects a code that was not issued', () => {
    const service = new OtpService();
    expect(() => service.verify('visitor@example.com', '000000')).toThrow(
      UnauthorizedException,
    );
  });
});

function jestLikeLog(service: OtpService, messages: string[]) {
  const logger = (
    service as unknown as { logger: { log: (message: string) => void } }
  ).logger;
  logger.log = (message: string) => {
    messages.push(message);
  };
}
