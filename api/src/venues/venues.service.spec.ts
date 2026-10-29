import { NotFoundException } from '@nestjs/common';
import { VenuesService } from './venues.service.js';

describe('VenuesService', () => {
  const service = new VenuesService();

  it('lists Adwa as an unverified placeholder', () => {
    expect(service.list()).toEqual({
      source: 'placeholder-seed',
      verified: false,
      venues: [
        expect.objectContaining({
          slug: 'adwa-museum',
          status: 'placeholder',
        }),
      ],
    });
  });

  it('returns the planned zones without claiming they are loaded content', () => {
    const venue = service.findBySlug('adwa-museum');
    expect(venue.verified).toBe(false);
    expect(venue.zones.map((zone) => zone.slug)).toEqual([
      'entrance',
      '5gna-ber',
      '6gna-ber',
      'coffee',
      'restaurant',
      'parking',
      'restrooms',
      'exits',
    ]);
  });

  it('does not invent a venue that is not in the seed', () => {
    expect(() => service.findBySlug('other')).toThrow(NotFoundException);
  });
});
