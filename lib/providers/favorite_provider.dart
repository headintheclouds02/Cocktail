//Cosa fa questa classe?
//
// Tiene la lista privata _favorites e fornisce un getter pubblico.
//
// Quando viene istanziata, carica i favoriti da backend (fetchFavorites).
//
// Permette di aggiungere o rimuovere un cocktail dalla lista dei favoriti con toggleFavorite.
//
// Comunica i cambiamenti agli ascoltatori con notifyListeners().
//
// Tiene traccia dello stato di caricamento con _isLoading.

import 'package:flutter/foundation.dart';
import '../model/favorite.dart';
import '../service/api_client.dart';
import '../service/auth_service.dart';
import '../service/token_storage.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Favorite> _favorites = [];

  List<Favorite> get favorites => _favorites;

  late final TokenStorage _storage;
  late final AuthService _authService;
  late final ApiClient _apiClient;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  FavoriteProvider() {
    _storage = TokenStorage();
    _authService = AuthService(baseUrl: 'http://10.0.2.2:8081', storage: _storage);
    _apiClient = ApiClient(baseUrl: 'http://10.0.2.2:8081', authService: _authService, storage: _storage);
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {
    _isLoading = true;
    notifyListeners();

    try {
      final token = await _storage.getAccessToken();
      if (token == null || token.isEmpty) {
        await _storage.clear();
        // Qui puoi decidere come gestire logout o redirect, eventualmente con un callback
        _favorites = [];
        _isLoading = false;
        notifyListeners();
        return;
      }

      final response = await _apiClient.dio.get('/api/favorites');
      final List<dynamic> data = response.data;
      _favorites = data.map((json) => Favorite.fromJson(json)).toList();
    } catch (e) {
      print('Errore fetchFavorites: $e');
      _favorites = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> toggleFavorite(int cocktailId) async {
    final isFav = _favorites.any((f) => f.cocktail.id == cocktailId);
    try {
      if (isFav) {
        await _apiClient.dio.delete('/api/favorites/$cocktailId');
        _favorites.removeWhere((f) => f.cocktail.id == cocktailId);
      } else {
        await _apiClient.dio.put('/api/favorites/toggle/$cocktailId');
        // Per semplicità, ricarichiamo la lista da backend
        await fetchFavorites();
      }
      notifyListeners();
    } catch (e) {
      print('Errore toggleFavorite: $e');
      rethrow;
    }
  }

  bool isFavorite(int cocktailId) {
    return _favorites.any((f) => f.cocktail.id == cocktailId);
  }
}
