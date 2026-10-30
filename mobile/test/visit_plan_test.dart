import 'package:flutter_test/flutter_test.dart';
import 'package:negarit_mobile/features/visit/data/visit_plan.dart';

void main() {
  test('starts at the entrance and ends at the exits', () {
    expect(
      visitPlan(const []).map((place) => place.slug).toList(),
      ['entrance', '5gna-ber', '6gna-ber', 'exits'],
    );
  });

  test('follows the selected interests and skips the halls', () {
    expect(
      visitPlan(const ['coffee']).map((place) => place.slug).toList(),
      ['entrance', 'coffee', 'exits'],
    );
  });
}
