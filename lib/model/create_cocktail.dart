import 'dart:ui';
import 'cocktail_ingredient.dart';

class CreateCocktail {
  final String name;
  final String description;
  final List<CocktailIngredient> cocktailIngredients;
  final String category;
  final String glassType;
  final String preparationMethod;
  final Image image;
  final bool alcoholic;

  CreateCocktail({
    required this.name,
    required this.description,
    required this.cocktailIngredients,
    required this.category,
    required this.glassType,
    required this.preparationMethod,
    required this.image,
    required this.alcoholic,
  });

  factory CreateCocktail.fromJson(Map<String, dynamic> json) {
    return CreateCocktail(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      cocktailIngredients: (json['cocktailIngredients'] as List<dynamic>?)
          ?.map((item) => CocktailIngredient.fromJson(item))
          .toList() ??
          [],
      category: json['category'] ?? '',
      glassType: json['glassType'] ?? '',
      preparationMethod: json['preparationMethod'] ?? '',
      image: json['imageUrl'],
      alcoholic: json['alcoholic'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'cocktailIngredients':
      cocktailIngredients.map((item) => item.toJson()).toList(),
      'category': category,
      'glassType': glassType,
      'preparationMethod': preparationMethod,
      'imageUrl': image,
      'alcoholic': alcoholic,
    };
  }


}
