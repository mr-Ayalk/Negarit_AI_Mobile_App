import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:negarit_mobile/core/config/api_base.dart';

class SignInException implements Exception {
  const SignInException.unreachable() : invalidCode = false;
  const SignInException.invalid() : invalidCode = true;

  final bool invalidCode;
}

class AuthApi {
  const AuthApi({this.baseUrl = apiBaseUrl});

  final String baseUrl;

  Future<void> requestCode(String destination) async {
    final response = await _post('/auth/otp/request', {
      'destination': destination,
    });
    if (response.statusCode != 201) {
      throw const SignInException.unreachable();
    }
  }

  Future<void> verifyCode(String destination, String code) async {
    final response = await _post('/auth/otp/verify', {
      'destination': destination,
      'code': code,
    });
    if (response.statusCode == 401) {
      throw const SignInException.invalid();
    }
    if (response.statusCode != 201) {
      throw const SignInException.unreachable();
    }
  }

  Future<http.Response> _post(String path, Map<String, String> body) async {
    try {
      return await http.post(
        Uri.parse('$baseUrl$path'),
        headers: const {'content-type': 'application/json'},
        body: jsonEncode(body),
      );
    } catch (_) {
      throw const SignInException.unreachable();
    }
  }
}
