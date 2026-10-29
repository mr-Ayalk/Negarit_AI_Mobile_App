import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:negarit_mobile/features/visit/data/visit_places.dart';
import 'package:shared_preferences/shared_preferences.dart';

const savedPlacesKey = 'saved-places';

class SavedPlacesController extends AsyncNotifier<List<String>> {
  @override
  Future<List<String>> build() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final stored = preferences.getStringList(savedPlacesKey) ?? const [];
      return stored.where((slug) => placeBySlug(slug) != null).toList();
    } catch (_) {
      return const [];
    }
  }

  Future<void> toggle(String slug) async {
    if (placeBySlug(slug) == null) {
      return;
    }
    final current = List<String>.from(state.value ?? const <String>[]);
    if (current.contains(slug)) {
      current.remove(slug);
    } else {
      current.add(slug);
    }
    state = AsyncData(current);
    try {
      final preferences = await SharedPreferences.getInstance();
      await preferences.setStringList(savedPlacesKey, current);
    } catch (_) {
      return;
    }
  }
}

final savedPlacesProvider =
    AsyncNotifierProvider<SavedPlacesController, List<String>>(
      SavedPlacesController.new,
    );
