import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:negarit_mobile/app.dart';
import 'package:negarit_mobile/core/widgets/negarit_button.dart';

void main() {
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
