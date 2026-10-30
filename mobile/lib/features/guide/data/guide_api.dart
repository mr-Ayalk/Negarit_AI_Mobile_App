import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:negarit_mobile/core/config/api_base.dart';

/// What the guide service decided. It is not a museum citation.
class GuideAnswer {
  const GuideAnswer({required this.kind, this.placeSlug});

  final String kind;
  final String? placeSlug;
}

/// Result of asking the API. [attempted] is false in widget tests.
class GuideFetch {
  const GuideFetch({required this.attempted, this.answer});

  final bool attempted;
  final GuideAnswer? answer;
}

GuideAnswer? guideAnswerFromJson(Object? json) {
  if (json is! Map) {
    return null;
  }
  final kind = json['kind'];
  final slug = json['placeSlug'];
  if (kind is! String) {
    return null;
  }
  if (kind != 'place' &&
      kind != 'halls' &&
      kind != 'overview' &&
      kind != 'unknown') {
    return null;
  }
  return GuideAnswer(
    kind: kind,
    placeSlug: slug is String && slug.isNotEmpty ? slug : null,
  );
}

/// Asks the mock guide. Widget tests skip the network.
Future<GuideFetch> askGuide(String question) async {
  if (WidgetsBinding.instance.runtimeType.toString().contains('Test')) {
    return const GuideFetch(attempted: false);
  }
  try {
    final response = await http
        .post(
          Uri.parse('$apiBaseUrl/guide/ask'),
          headers: {'content-type': 'application/json'},
          body: jsonEncode({'question': question}),
        )
        .timeout(const Duration(seconds: 3));
    if (response.statusCode != 201) {
      return const GuideFetch(attempted: true);
    }
    return GuideFetch(
      attempted: true,
      answer: guideAnswerFromJson(jsonDecode(response.body)),
    );
  } catch (_) {
    return const GuideFetch(attempted: true);
  }
}
