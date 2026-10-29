import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionController extends Notifier<String?> {
  @override
  String? build() => null;

  void signIn(String destination) {
    state = destination;
  }
}

final sessionProvider = NotifierProvider<SessionController, String?>(
  SessionController.new,
);
