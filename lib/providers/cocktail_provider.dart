import 'package:flutter/foundation.dart';
import '../model/cocktail.dart';
import '../service/api_client.dart';
import '../service/token_storage.dart';

class CocktailProvider extends ChangeNotifier {
  final ApiClient apiClient;
  final TokenStorage storage;

  CocktailProvider({
    required this.apiClient,
    required this.storage,
  });

  List<Cocktail> _cocktails = [];
  bool isLoading = false;
  bool _loaded = false;

  List<Cocktail> get cocktails => _cocktails;

  Future<void> fetchCocktails({bool forceRefresh = false}) async {
    if (_loaded && !forceRefresh) return;

    isLoading = true;
    notifyListeners();

    final valid = await storage.isAccessTokenValid();
    if (!valid) {
      isLoading = false;
      notifyListeners();
      throw Exception('Session expired');
    }

    try {
      final response =
      await apiClient.dio.get('/api/user/cocktails');

      _cocktails = (response.data['content'] as List)
          .map((e) => Cocktail.fromJson(e))
          .toList();

      _loaded = true;
    } catch (e) {
      debugPrint('fetchCocktails error → $e');
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  List<String> get categories =>
      _cocktails.map((c) => c.category).toSet().toList()..sort();
}
