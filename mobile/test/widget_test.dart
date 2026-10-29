import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:negarit_mobile/app.dart';
import 'package:negarit_mobile/core/widgets/negarit_button.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('explore shell shows the empty venue state', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: NegaritApp()));
    await tester.pumpAndSettle();

    expect(find.text('Welcome,'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('5gna Ber'), 400);
    expect(find.text('5gna Ber'), findsOneWidget);
    expect(find.text('Places'), findsOneWidget);
    expect(
      find.text('Start at the entrance, then 5gna Ber and 6gna Ber.'),
      findsOneWidget,
    );
    expect(find.text('Explore'), findsOneWidget);
  });

  testWidgets('profile can switch the visit language to Arabic', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: NegaritApp()));
    await tester.pumpAndSettle();

    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Profile'),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Language'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('العربية'));
    await tester.pumpAndSettle();

    expect(find.text('الملف'), findsWidgets);
  });

  testWidgets('ask a question opens the unconnected guide', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: NegaritApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ask a question'));
    await tester.pumpAndSettle();

    expect(find.text('Ask about the places on this visit.'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Where is the hall?');
    await tester.tap(find.byTooltip('Send'));
    await tester.pumpAndSettle();

    expect(find.text('Where is the hall?'), findsOneWidget);
    expect(
      find.text('The halls on this visit are 5gna Ber and 6gna Ber.'),
      findsOneWidget,
    );
  });

  testWidgets('map tab shows the map empty state', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: NegaritApp()));
    await tester.pumpAndSettle();

    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Map'),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text(
        'Entrance, halls, coffee, restaurant, parking, restrooms, and exits.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('Arabic locale lays out right to left', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: NegaritApp(locale: Locale('ar'))),
    );
    await tester.pumpAndSettle();

    final context = tester.element(find.text('استكشف'));
    expect(Directionality.of(context), TextDirection.rtl);
  });

  testWidgets('saving a place shows it in favorites', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: NegaritApp()));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text('5gna Ber'), 400);
    await tester.tap(find.text('5gna Ber'));
    await tester.pumpAndSettle();

    expect(
      find.text('A reviewed story is not loaded for this place.'),
      findsOneWidget,
    );
    await tester.tap(find.text('Save place'));
    await tester.pumpAndSettle();
    expect(find.text('Saved'), findsOneWidget);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Favorites'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('5gna Ber'), findsOneWidget);
    expect(find.text('Hall'), findsOneWidget);
  });

  testWidgets('profile stores interests and a signed-in visitor', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({
      'signed-in-destination': 'visitor@example.com',
    });
    await tester.pumpWidget(const ProviderScope(child: NegaritApp()));
    await tester.pumpAndSettle();

    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Profile'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('visitor@example.com'), findsOneWidget);

    await tester.tap(find.text('Interests'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Halls'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();
    expect(find.text('Halls'), findsOneWidget);

    await tester.tap(find.text('Sign out'));
    await tester.pumpAndSettle();
    expect(find.text('Guest'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
  });

  testWidgets('primary button ignores taps while loading', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NegaritButton(
            label: 'Continue',
            isLoading: true,
            onPressed: () => taps++,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(NegaritButton));
    await tester.pump();
    expect(taps, 0);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
