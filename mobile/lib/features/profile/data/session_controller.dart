import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const signedInDestinationKey = 'signed-in-destination';

class SessionController extends AsyncNotifier<String?> {
  @override
  Future<String?> build() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final destination = preferences.getString(signedInDestinationKey);
      if (destination == null || destination.length < 5) {
        return null;
      }
      return destination;
    } catch (_) {
      return null;
    }
  }

  Future<void> signIn(String destination) async {
    final trimmed = destination.trim();
    state = AsyncData(trimmed);
    try {
      final preferences = await SharedPreferences.getInstance();
      await preferences.setString(signedInDestinationKey, trimmed);
    } catch (_) {
      return;
    }
  }

  Future<void> signOut() async {
    state = const AsyncData(null);
    try {
      final preferences = await SharedPreferences.getInstance();
      await preferences.remove(signedInDestinationKey);
    } catch (_) {
      return;
    }
  }
}

final sessionProvider = AsyncNotifierProvider<SessionController, String?>(
  SessionController.new,
);
