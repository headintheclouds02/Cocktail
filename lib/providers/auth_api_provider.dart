import 'package:flutter/material.dart';
import '../model/cocktail.dart';
import '../service/api_client.dart';
import '../service/auth_service.dart';
import '../service/token_storage.dart';

class AuthApiProvider with ChangeNotifier {
  late final TokenStorage _storage;
  late final AuthService _authService;
  late final ApiClient _apiClient;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  ApiClient get apiClient => _apiClient;

  AuthApiProvider() {
    _storage = TokenStorage();
    _authService = AuthService(baseUrl: 'http://10.0.2.2:8081', storage: _storage);
    _apiClient = ApiClient(
      baseUrl: 'http://10.0.2.2:8081',
      authService: _authService,
      storage: _storage,
      onLogout: _handleLogout,
    );
    _init();
  }

  Future<List<Cocktail>> fetchCocktails() async {
    final valid = await isAccessTokenValid();
    if (!valid) {
      await logout();
      throw Exception('Session expired');
    }

    final response = await apiClient.dio.get('/api/user/cocktails');
    final List<dynamic> data = response.data['content'];
    return data.map((json) => Cocktail.fromJson(json)).toList();
  }


  Future<void> _init() async {
    // Controlla se il token è presente e valido all'avvio
    final token = await _storage.getAccessToken();
    _isLoggedIn = token != null && token.isNotEmpty;
    notifyListeners();
  }

  void _handleLogout() async {
    await _storage.clear();
    _isLoggedIn = false;
    notifyListeners();
    // Qui puoi aggiungere eventuale logica globale di navigazione o alert
  }

  Future<void> login(String username, String password) async {
    try {
      final auth = await _authService.login(username, password);
      _isLoggedIn = true;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await _storage.clear();
    _isLoggedIn = false;
    notifyListeners();
  }

  Future<bool> isAccessTokenValid() async {
    return await _storage.isAccessTokenValid();
  }
}
