import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/auth_response.dart';

class AuthService {
  static const String baseUrl = 'https://maybe.dartondox.dev/api/v1';
  static const String loginEndpoint = '/auth/login';
  static const String refreshEndpoint = '/auth/refresh';

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$loginEndpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'device': {
            'device_id': 'aj-iphone',
            'device_name': 'AJ iPhone',
            'device_type': 'ios',
            'os_version': '18.0',
            'app_version': '1.0.1',
          },
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final authResponse = AuthResponse.fromJson(data);
        return {'success': true, 'data': authResponse};
      } else {
        final errorData = jsonDecode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Login failed',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }

  static Future<Map<String, dynamic>> refreshToken({
    required String refreshToken,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$refreshEndpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'refresh_token': refreshToken,
          'device': {
            'device_id': 'aj-iphone',
            'device_name': 'AJ iPhone',
            'device_type': 'ios',
            'os_version': '18.0',
            'app_version': '1.0.1',
          },
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final authResponse = AuthResponse.fromJson(data);
        return {'success': true, 'data': authResponse};
      } else {
        final errorData = jsonDecode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Token refresh failed',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }
}
