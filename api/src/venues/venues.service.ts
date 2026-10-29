import { Injectable, NotFoundException } from '@nestjs/common';
import { adwaPlaceholder } from './adwa-placeholder.js';

@Injectable()
export class VenuesService {
  list() {
    return {
      source: adwaPlaceholder.source,
      verified: adwaPlaceholder.verified,
      venues: [adwaPlaceholder.venue],
    };
  }

  findBySlug(slug: string) {
    if (slug !== adwaPlaceholder.venue.slug) {
      throw new NotFoundException(`No venue is loaded for ${slug}.`);
    }
    return adwaPlaceholder;
  }
}
