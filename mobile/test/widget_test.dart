import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:negarit_mobile/app.dart';
import 'package:negarit_mobile/core/widgets/negarit_button.dart';

void main() {
  testWidgets('explore shell shows the empty venue state', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: NegaritApp()));
    await tester.pumpAndSettle();

    expect(find.text('Welcome to Negarit'), findsOneWidget);
    expect(find.text('No venue loaded'), findsOneWidget);
    expect(find.text('Explore'), findsOneWidget);
    expect(find.text('Map'), findsOneWidget);
  });

  testWidgets('map tab shows the map empty state', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: NegaritApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Map'));
    await tester.pumpAndSettle();

    expect(find.text('Map is waiting for a venue'), findsOneWidget);
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
