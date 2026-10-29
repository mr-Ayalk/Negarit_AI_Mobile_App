import { BadGatewayException, Injectable } from '@nestjs/common';
import { chapaSecret } from '../config/env.js';

export type ChapaSessionInput = {
  amount: number;
  currency?: string;
  email: string;
  txRef: string;
  firstName?: string;
  lastName?: string;
};

@Injectable()
export class ChapaService {
  async createSession(input: ChapaSessionInput) {
    const secret = chapaSecret();
    if (!secret) {
      throw new BadGatewayException('Chapa secret is missing.');
    }

    const response = await fetch(
      'https://api.chapa.co/v1/transaction/initialize',
      {
        method: 'POST',
        headers: {
          Authorization: `Bearer ${secret}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          amount: input.amount.toString(),
          currency: input.currency ?? 'ETB',
          email: input.email,
          first_name: input.firstName ?? 'Visitor',
          last_name: input.lastName ?? 'Guest',
          tx_ref: input.txRef,
          customization: {
            title: 'Negarit AI',
            description: 'Museum visit',
          },
        }),
      },
    );

    const body = (await response.json()) as {
      status?: string;
      message?: string;
      data?: { checkout_url?: string };
    };

    if (!response.ok || body.status !== 'success' || !body.data?.checkout_url) {
      throw new BadGatewayException(
        body.message ?? 'Chapa did not return a checkout URL.',
      );
    }

    return {
      mode: 'chapa' as const,
      checkoutUrl: body.data.checkout_url,
    };
  }
}
