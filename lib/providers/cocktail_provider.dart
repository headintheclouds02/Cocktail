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

  Future<List<Cocktail>> fetchCocktails() async {
    final valid = await storage.isAccessTokenValid();
    if (!valid) {
      throw Exception('Session expired');
    }

    final response = await apiClient.dio.get('/api/user/cocktails');
    final List<dynamic> data = response.data['content'];
    return data.map((json) => Cocktail.fromJson(json)).toList();
  }
}
