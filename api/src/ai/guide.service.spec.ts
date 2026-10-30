import { describe, expect, it } from 'vitest';
import { answerVisit } from './guide.service.js';

describe('answerVisit', () => {
  it('names one place without calling a model', () => {
    expect(answerVisit('Where is the coffee?')).toEqual({
      provider: 'mock',
      verified: false,
      source: 'visit-list',
      kind: 'place',
      placeSlug: 'coffee',
    });
  });

  it('keeps a hall question off a single place', () => {
    expect(answerVisit('Where is the hall?').kind).toBe('halls');
    expect(answerVisit('Where is the hall?').placeSlug).toBeNull();
  });

  it('refuses a question that is not on the visit list', () => {
    expect(answerVisit('Who led the battle?')).toMatchObject({
      kind: 'unknown',
      verified: false,
      placeSlug: null,
    });
  });
});
