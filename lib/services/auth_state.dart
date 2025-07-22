import 'package:flutter/material.dart';

import '../models/auth_response.dart';
import 'storage_service.dart';

class AuthState extends ChangeNotifier {
  bool _isLoggedIn = false;
  User? _user;
  String? _accessToken;
  String? _refreshToken;

  bool get isLoggedIn => _isLoggedIn;
  User? get user => _user;
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;

  // Initialize auth state from storage
  Future<void> initializeAuth() async {
    final hasValidToken = await StorageService.hasValidToken();
    if (hasValidToken) {
      final user = await StorageService.getUserData();
      final accessToken = await StorageService.getAccessToken();
      final refreshToken = await StorageService.getRefreshToken();

      if (user != null && accessToken != null && refreshToken != null) {
        _user = user;
        _accessToken = accessToken;
        _refreshToken = refreshToken;
        _isLoggedIn = true;
        notifyListeners();
      }
    }
  }

  Future<void> setLoggedIn(AuthResponse authResponse) async {
    _isLoggedIn = true;
    _user = authResponse.user;
    _accessToken = authResponse.accessToken;
    _refreshToken = authResponse.refreshToken;

    // Save to local storage
    await StorageService.saveAuthData(authResponse);

    notifyListeners();
  }

  Future<void> refreshAuth(AuthResponse authResponse) async {
    _accessToken = authResponse.accessToken;
    _refreshToken = authResponse.refreshToken;

    // Save to local storage
    await StorageService.saveAuthData(authResponse);

    notifyListeners();
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    _user = null;
    _accessToken = null;
    _refreshToken = null;

    // Clear from local storage
    await StorageService.clearAuthData();

    notifyListeners();
  }

  // Check if token needs refresh
  Future<bool> needsTokenRefresh() async {
    return await StorageService.isTokenExpired();
  }
}
