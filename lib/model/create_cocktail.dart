import 'dart:io';
import 'package:dio/dio.dart';
import 'cocktail_ingredient.dart';

class CreateCocktail {
  final String name;
  final String description;
  final List<CocktailIngredient> cocktailIngredients;
  final String category;
  final String glassType;
  final String preparationMethod;
  final bool alcoholic;

  /// URL restituito da POST /api/images/upload
  final String? imageUrl;

  CreateCocktail({
    required this.name,
    required this.description,
    required this.cocktailIngredients,
    required this.category,
    required this.glassType,
    required this.preparationMethod,
    required this.alcoholic,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'ingredients': cocktailIngredients.map((cocktailIng) {
        final ingr = cocktailIng.ingredient;
        return {
          'name': ingr.name,
          'quantity': cocktailIng.quantity,
          'category': ingr.category,
          'unit': ingr.unit,
        };
      }).toList(),
      'category': category,
      'glassType': glassType,
      'preparationMethod': preparationMethod,
      'alcoholic': alcoholic,
      if (imageUrl != null) 'imageUrl': imageUrl,
    };
  }

  Future<Response> create(
      Dio dio, {
        String path = '/api/cocktails',
      }) {
    return dio.post(path, data: toJson());
  }

  /// Upload dell’immagine e ritorno dell’URL
  static Future<String> uploadImage(
      Dio dio,
      File imageFile, {
        String path = '/api/images/upload',
      }) async {
    if (!await imageFile.exists()) {
      throw Exception('File immagine non trovato: ${imageFile.path}');
    }

    final filename = imageFile.path.split(Platform.pathSeparator).last;

    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        imageFile.path,
        filename: filename,
      ),
    });

    final response = await dio.post(path, data: formData);

    final data = response.data;
    if (data == null || data['url'] == null) {
      throw Exception('Upload immagine fallito: risposta non valida');
    }

    return data['url'] as String;
  }
}
