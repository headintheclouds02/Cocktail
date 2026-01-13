import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../service/api_client.dart';
import '../model/create_cocktail.dart';

class SaveProvider extends ChangeNotifier {
  final ApiClient api;
  bool isLoading = false;

  SaveProvider({required this.api});

  Dio get dio => api.dio;

  Future<void> saveCocktail(
      CreateCocktail model, {
        File? imageFile,
      }) async {
    isLoading = true;
    notifyListeners();

    try {
      String? imageUrl;
      if (imageFile != null) {
        imageUrl = await CreateCocktail.uploadImage(
          api.dio,
          imageFile,
        );
      }


      final cocktailWithImage = CreateCocktail(
        name: model.name,
        description: model.description,
        cocktailIngredients: model.cocktailIngredients,
        category: model.category,
        glassType: model.glassType,
        preparationMethod: model.preparationMethod,
        alcoholic: model.alcoholic,
        imageUrl: imageUrl,
      );

      debugPrint(cocktailWithImage.toJson().toString());



      await cocktailWithImage.create(api.dio);
    } catch (e, st) {
      debugPrint('saveCocktail error: $e\n$st');
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
