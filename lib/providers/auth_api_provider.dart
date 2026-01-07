import 'package:flutter/material.dart';
import '../model/auth_response.dart';
import '../model/cocktail.dart';
import '../service/api_client.dart';
import '../service/auth_service.dart';
import '../service/token_storage.dart';

class AuthApiProvider extends ChangeNotifier {
  final AuthService authService;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  AuthApiProvider({required this.authService}) {
    _init();
  }

  Future<void> _init() async {
    _isLoggedIn = await authService.storage.isAccessTokenValid();
    notifyListeners();
  }

  Future<void> login(String u, String p) async {
    await authService.login(u, p);
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> logout() async {
    await authService.storage.clear();
    _isLoggedIn = false;
    notifyListeners();
  }
}

