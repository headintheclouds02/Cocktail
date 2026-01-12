import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../model/favorite.dart';
import '../service/api_client.dart';

class FavoriteProvider extends ChangeNotifier {
  final ApiClient api;

  final void Function(String message)? _onShowMessage;
  List<Favorite> favorites = [];
  bool isLoading = false;

  FavoriteProvider({
    required this.api,
    void Function(String message)? onShowMessage,
  }) : _onShowMessage = onShowMessage {
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {
    isLoading = true;
    notifyListeners();

    try {
      final res = await api.dio.get('/api/favorites');
      favorites = (res.data as List).map((j) => Favorite.fromJson(j)).toList();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(int cocktailId) async {
    final isFav = favorites.any((f) => f.cocktail.id == cocktailId);

    try {
      if (isFav) {
        await api.dio.delete('/api/favorites/$cocktailId');

        favorites.removeWhere((f) => f.cocktail.id == cocktailId);
        _onShowMessage?.call('Cocktail rimosso dai preferiti');
      } else {
        await api.dio.put('/api/favorites/toggle/$cocktailId');

        await fetchFavorites();
        _onShowMessage?.call('Cocktail aggiunto ai preferiti');
      }
      notifyListeners();
    } catch (e, stacktrace) {
      print('Errore toggleFavorite: $e');
      print(stacktrace);

      rethrow;
    }
  }

  bool isFavorite(int cocktailId) {
    return favorites.any((f) => f.cocktail.id == cocktailId);
  }



  void clear() {
  favorites.clear();
  notifyListeners();
  }

}
