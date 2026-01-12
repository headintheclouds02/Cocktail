import 'package:flutter/material.dart';
import '../service/auth_service.dart';
import '../model/auth_response.dart';

class AuthApiProvider extends ChangeNotifier {
  final AuthService authService;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  AuthResponse? _auth;
  AuthResponse? get auth => _auth;

  AuthApiProvider({required this.authService}) {
    _init();
  }

  Future<void> _init() async {
    _isLoggedIn = await authService.storage.isAccessTokenValid();

    if (_isLoggedIn) {
      final accessToken = await authService.storage.getAccessToken();
      if (accessToken != null && accessToken.isNotEmpty) {
        _auth = AuthResponse.fromJson({
          'token': accessToken,
          'refreshToken': await authService.storage.getRefreshToken(),
        });
      }
    }

    notifyListeners();
  }

  Future<void> login(String u, String p) async {
    final auth = await authService.login(u, p);

    _auth = auth;
    _isLoggedIn = true;

    notifyListeners();
  }

  Future<void> logout() async {
    await authService.storage.clear();

    _auth = null;
    _isLoggedIn = false;

    notifyListeners();
  }

  String? _avatarPath;
  String? get avatarPath => _avatarPath;

  Future<void> loadAvatar() async {
    _avatarPath = await authService.storage.getAvatar();
    notifyListeners();
  }

  Future<void> setAvatar(String path) async {
    _avatarPath = path;
    await authService.storage.saveAvatar(path);
    notifyListeners();
  }
}

