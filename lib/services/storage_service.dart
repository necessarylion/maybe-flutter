import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_response.dart';

class StorageService {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userDataKey = 'user_data';
  static const String _tokenExpiryKey = 'token_expiry';

  static Future<void> saveAuthData(AuthResponse authResponse) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_accessTokenKey, authResponse.accessToken);
    await prefs.setString(_refreshTokenKey, authResponse.refreshToken);

    if (authResponse.user != null) {
      await prefs.setString(
        _userDataKey,
        jsonEncode(authResponse.user!.toJson()),
      );
    }

    // Calculate token expiry time
    final expiryTime =
        DateTime.now().millisecondsSinceEpoch + (authResponse.expiresIn * 1000);
    await prefs.setInt(_tokenExpiryKey, expiryTime);
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  static Future<User?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString(_userDataKey);

    if (userDataString != null) {
      try {
        final userData = jsonDecode(userDataString);
        return User.fromJson(userData);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  static Future<bool> isTokenExpired() async {
    final prefs = await SharedPreferences.getInstance();
    final expiryTime = prefs.getInt(_tokenExpiryKey);

    if (expiryTime == null) return true;

    final now = DateTime.now().millisecondsSinceEpoch;
    return now >= expiryTime;
  }

  static Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
    await prefs.remove(_userDataKey);
    await prefs.remove(_tokenExpiryKey);
  }

  static Future<bool> hasValidToken() async {
    final token = await getAccessToken();
    if (token == null) return false;

    return !await isTokenExpired();
  }
}
