import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/account_response.dart';
import '../models/auth_response.dart';
import 'auth_service.dart';
import 'storage_service.dart';

class AccountsService {
  static const String baseUrl = 'https://maybe.dartondox.dev/api/v1';
  static const String accountsEndpoint = '/accounts';

  static Future<Map<String, dynamic>> getAccounts({
    int page = 1,
    int perPage = 100,
  }) async {
    try {
      // Get access token from storage
      final accessToken = await StorageService.getAccessToken();

      if (accessToken == null) {
        return {'success': false, 'message': 'No access token available'};
      }

      final response = await http.get(
        Uri.parse('$baseUrl$accountsEndpoint?page=$page&per_page=$perPage'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final accountResponse = AccountResponse.fromJson(data);
        return {'success': true, 'data': accountResponse};
      } else if (response.statusCode == 401) {
        // Token expired, try to refresh
        final refreshResult = await _refreshToken();
        if (refreshResult['success']) {
          // Retry the request with new token
          return await getAccounts(page: page, perPage: perPage);
        } else {
          return {
            'success': false,
            'message': 'Session expired. Please login again.',
            'needsLogin': true,
          };
        }
      } else {
        final errorData = jsonDecode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Failed to fetch accounts',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }

  static Future<Map<String, dynamic>> _refreshToken() async {
    try {
      final refreshToken = await StorageService.getRefreshToken();

      if (refreshToken == null) {
        return {'success': false, 'message': 'No refresh token available'};
      }

      final result = await AuthService.refreshToken(refreshToken: refreshToken);

      if (result['success']) {
        // Save the new tokens
        final authResponse = result['data'] as AuthResponse;
        await StorageService.saveAuthData(authResponse);
        return {'success': true};
      } else {
        return result;
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Token refresh failed: ${e.toString()}',
      };
    }
  }
}
