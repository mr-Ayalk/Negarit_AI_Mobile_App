import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:negarit_mobile/features/visit/data/visit_places.dart';

class MapFocusController extends Notifier<String?> {
  @override
  String? build() => null;

  void show(String slug) {
    if (placeBySlug(slug) == null) {
      return;
    }
    state = slug;
  }
}

final mapFocusProvider = NotifierProvider<MapFocusController, String?>(
  MapFocusController.new,
);
