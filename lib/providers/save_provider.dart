import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../service/api_client.dart';
import '../service/auth_service.dart';
import '../service/token_storage.dart';

class SaveProvider extends ChangeNotifier {
  final TokenStorage _storage;
  final AuthService _authService;
  final ApiClient _apiClient;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  SaveProvider({void Function(String message)? onShowMessage})
      : _storage = TokenStorage(),
        _authService = AuthService(
          baseUrl: 'http://10.0.2.2:8081',
          storage: TokenStorage(),
        ),
        _apiClient = ApiClient(
          baseUrl: 'http://10.0.2.2:8081',
          authService: AuthService(
            baseUrl: 'http://10.0.2.2:8081',
            storage: TokenStorage(),
          ),
          storage: TokenStorage(),
        );

  Future<void> createCocktail(Map<String, dynamic> payload) async {
    _isLoading = true;
    notifyListeners();

    try {
      final token = await _storage.getAccessToken();
      if (token == null || token.isEmpty) {
        throw Exception('Token non valido');
      }

      await _apiClient.dio.post(
        '/api/cocktails',
        data: payload,
      );
    } catch (e) {
      debugPrint('Errore createCocktail: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

