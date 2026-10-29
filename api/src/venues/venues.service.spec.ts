import { NotFoundException } from '@nestjs/common';
import { VenuesService } from './venues.service.js';

describe('VenuesService', () => {
  const service = new VenuesService();

  it('lists Adwa as an unverified placeholder', async () => {
    expect(await service.list()).toEqual({
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

  it('returns the planned zones without claiming they are loaded content', async () => {
    const venue = await service.findBySlug('adwa-museum');
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
    expect(venue.zones.find((zone) => zone.slug === 'entrance')?.content).toEqual(
      [
        {
          language: 'en',
          body: 'Placeholder. This is not a reviewed museum source.',
          provenance: 'placeholder',
          status: 'placeholder',
        },
        {
          language: 'am',
          body: 'ይህ የተረጋገጠ የሙዚየም ጽሑፍ አይደለም።',
          provenance: 'placeholder',
          status: 'placeholder',
        },
      ],
    );
    expect(venue.zones.find((zone) => zone.slug === 'coffee')?.content).toEqual(
      [],
    );
  });

  it('does not invent a venue that is not in the seed', async () => {
    await expect(service.findBySlug('other')).rejects.toBeInstanceOf(
      NotFoundException,
    );
  });
});
