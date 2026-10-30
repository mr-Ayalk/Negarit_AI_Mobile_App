import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:negarit_mobile/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('the app opens on choose language and walks into the visit', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: NegaritApp()));
    await tester.pumpAndSettle();

    expect(find.text('Choose your language'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
    expect(find.text('አማርኛ'), findsOneWidget);

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text('Let Negarit guide you'), findsOneWidget);
    expect(find.text('Bluetooth'), findsOneWidget);

    await tester.tap(find.text('Not now – I’ll choose my spot manually'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome to Negarit'), findsOneWidget);
    expect(find.text('Phone number'), findsOneWidget);

    await tester.tap(find.text('Send code'));
    await tester.pumpAndSettle();
    expect(find.text('Enter a phone number or email.'), findsOneWidget);
    expect(find.text('Where are you visiting?'), findsNothing);

    await tester.tap(find.text('Continue as guest'));
    await tester.pumpAndSettle();
    expect(find.text('Where are you visiting?'), findsOneWidget);
    expect(find.text('Adwa Museum'), findsOneWidget);
    expect(find.text('Friendship Park'), findsOneWidget);

    await tester.tap(find.text('Enter Adwa Museum'));
    await tester.pumpAndSettle();
    expect(find.text('Hi Guest'), findsOneWidget);
    expect(find.text('Start guided tour'), findsOneWidget);
    expect(find.text('Nearby exhibits'), findsOneWidget);
    expect(find.text('Explore'), findsOneWidget);

    await tester.tap(find.text('Start guided tour'));
    await tester.pumpAndSettle();
    expect(
      find.text('Hello Guest, welcome to Adwa Museum'),
      findsOneWidget,
    );
    expect(find.text('Hear the welcome'), findsOneWidget);

    await tester.tap(find.text('Begin my visit'));
    await tester.pumpAndSettle();
    expect(find.text('5gna Ber'), findsOneWidget);
    expect(find.text('Traditional warrior cape'), findsOneWidget);
    expect(find.text('Zone 3 of 8'), findsOneWidget);

    await tester.tap(find.text('View'));
    await tester.pumpAndSettle();
    expect(find.text('Warrior cape'), findsOneWidget);
    expect(find.text('Pay now'), findsOneWidget);

    await tester.tap(find.text('Pay now'));
    await tester.pumpAndSettle();
    expect(find.text('Checkout'), findsOneWidget);
    expect(find.text('Telebirr'), findsOneWidget);
    expect(find.text('Pay 2,400 ETB'), findsOneWidget);
  });

  testWidgets('home opens the map, the guide, the plan, and profile', (
    tester,
  ) async {
    await _openHome(tester);

    await tester.tap(find.text('Map'));
    await tester.pumpAndSettle();
    expect(find.text('Nearest coffee'), findsOneWidget);
    expect(find.text('On this visit'), findsWidgets);

    await tester.tap(find.text('Explore'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('See all'));
    await tester.pumpAndSettle();
    expect(find.text('Plan my visit'), findsOneWidget);
    expect(find.text('Entrance hall'), findsOneWidget);
    expect(find.text('Start this plan'), findsOneWidget);

    await tester.tap(find.text('Ask AI').hitTestable());
    await tester.pumpAndSettle();
    expect(find.text('Negarit guide'), findsOneWidget);
    expect(find.text('من هو الراس ألولا؟'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back_rounded).hitTestable());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Profile').hitTestable());
    await tester.pumpAndSettle();
    expect(find.text('Guest'), findsOneWidget);
    expect(find.text('Audio narration'), findsOneWidget);
    expect(find.text('Not on this phone'), findsOneWidget);
    expect(find.text('Sign in'), findsWidgets);
  });

  testWidgets('choosing Amharic changes the screen language', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: NegaritApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('አማርኛ'));
    await tester.pumpAndSettle();
    expect(find.text('ቋንቋ ይምረጡ'), findsOneWidget);

    await tester.tap(find.text('ቀጥል'));
    await tester.pumpAndSettle();
    expect(find.text('ነጋሪት ይምራዎት'), findsOneWidget);
  });

  testWidgets('food opens the break sheet', (tester) async {
    await _openHome(tester);
    await tester.tap(find.text('Food'));
    await tester.pumpAndSettle();
    expect(find.text('Need a break?'), findsOneWidget);
    expect(find.text('Museum Café'), findsOneWidget);
    expect(find.text('Tigist Restaurant'), findsOneWidget);
  });
}

Future<void> _openHome(WidgetTester tester) async {
  await tester.pumpWidget(const ProviderScope(child: NegaritApp()));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Continue'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Not now – I’ll choose my spot manually'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Continue as guest'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Enter Adwa Museum'));
  await tester.pumpAndSettle();
}
