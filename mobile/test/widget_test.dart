import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:negarit_mobile/app.dart';
import 'package:negarit_mobile/core/widgets/opening_splash.dart';
import 'package:negarit_mobile/features/map/presentation/map_screen.dart';
import 'package:negarit_mobile/core/widgets/negarit_button.dart';
import 'package:negarit_mobile/core/widgets/negarit_chip.dart';

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
    expect(find.text('1. Entrance'), findsOneWidget);
    expect(find.text('4. Exits'), findsOneWidget);
    expect(
      find.text('This order is not a measured route.'),
      findsOneWidget,
    );
    expect(find.text('Explore'), findsOneWidget);
  });

  testWidgets('a coffee interest shortens the visit order', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: NegaritApp()));
    await tester.pumpAndSettle();

    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Profile'),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Interests'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Coffee'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();

    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Explore'),
      ),
    );
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('This visit follows your interests.'),
      400,
    );

    expect(find.text('1. Entrance'), findsOneWidget);
    expect(find.text('2. Coffee'), findsOneWidget);
    expect(find.text('3. Exits'), findsOneWidget);
    expect(find.text('2. 5gna Ber'), findsNothing);
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

    await tester.tap(
      find.descendant(
        of: find.byType(MapScreen),
        matching: find.text('Coffee'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Coffee is on this visit.'), findsOneWidget);
    expect(
      find.text('The drawing is not a measured route.'),
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

  testWidgets('simulated entrance welcomes the visitor once', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: NegaritApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(NegaritChip, "I'm here"));
    await tester.pumpAndSettle();
    expect(
      find.text('Simulated. This phone is not scanning Bluetooth.'),
      findsOneWidget,
    );

    await tester.tap(find.widgetWithText(ListTile, 'Entrance'));
    await tester.pumpAndSettle();
    expect(
      find.text('Hello Guest, welcome to Adwa Museum.'),
      findsOneWidget,
    );
    expect(
      find.text('A reviewed story is not loaded for this place.'),
      findsOneWidget,
    );

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(NegaritChip, "I'm here"));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ListTile, 'Entrance'));
    await tester.pumpAndSettle();
    expect(find.text('This place was already announced.'), findsOneWidget);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(NegaritChip, "I'm here"));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ListTile, '5gna Ber'));
    await tester.pumpAndSettle();
    expect(find.text('You are at 5gna Ber.'), findsOneWidget);
  });

  testWidgets('a printed place code opens that place', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: NegaritApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(NegaritChip, "I'm here"));
    await tester.pumpAndSettle();
    expect(
      find.text(
        'Type the text a printed QR would carry. The camera is not scanning.',
      ),
      findsOneWidget,
    );

    await tester.enterText(find.byType(TextField), 'lobby');
    await tester.tap(find.text('Use this code'));
    await tester.pumpAndSettle();
    expect(
      find.text('That code is not a place on this visit.'),
      findsOneWidget,
    );

    await tester.enterText(find.byType(TextField), 'negarit://place/coffee');
    await tester.tap(find.text('Use this code'));
    await tester.pumpAndSettle();
    expect(find.text('You are at Coffee.'), findsOneWidget);
  });

  testWidgets('asking for coffee opens that place on the map', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: NegaritApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ask a question'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Where is the coffee?');
    await tester.tap(find.byTooltip('Send'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Map'));
    await tester.pumpAndSettle();

    expect(find.text('Coffee is on this visit.'), findsOneWidget);
    expect(find.text('The drawing is not a measured route.'), findsOneWidget);
  });

  testWidgets('opening grows the logo from a dot', (tester) async {
    var finished = false;
    await tester.pumpWidget(
      MaterialApp(
        home: OpeningSplash(onFinished: () => finished = true),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump();
    expect(find.byType(Image), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    expect(finished, isTrue);
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
