import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:negarit_mobile/features/visit/data/visit_places.dart';
import 'package:shared_preferences/shared_preferences.dart';

const visitInterestsKey = 'visit-interests';

class InterestsController extends AsyncNotifier<List<String>> {
  @override
  Future<List<String>> build() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final stored = preferences.getStringList(visitInterestsKey) ?? const [];
      return stored.where(visitInterestIds.contains).toList();
    } catch (_) {
      return const [];
    }
  }

  Future<void> toggle(String interestId) async {
    if (!visitInterestIds.contains(interestId)) {
      return;
    }
    final current = List<String>.from(state.value ?? const <String>[]);
    if (current.contains(interestId)) {
      current.remove(interestId);
    } else {
      current.add(interestId);
    }
    current.sort(
      (a, b) => visitInterestIds.indexOf(a).compareTo(visitInterestIds.indexOf(b)),
    );
    state = AsyncData(current);
    try {
      final preferences = await SharedPreferences.getInstance();
      await preferences.setStringList(visitInterestsKey, current);
    } catch (_) {
      return;
    }
  }
}

final interestsProvider =
    AsyncNotifierProvider<InterestsController, List<String>>(
      InterestsController.new,
    );
