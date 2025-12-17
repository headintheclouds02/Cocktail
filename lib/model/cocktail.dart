import 'cocktail_ingredient.dart';

class Cocktail {
  final int id;
  final String name;
  final String description;
  final List<CocktailIngredient> cocktailIngredients;
  final String category;
  final String glassType;
  final String preparationMethod;
  final String? imageUrl;
  final bool alcoholic;

  Cocktail({
    required this.id,
    required this.name,
    required this.description,
    required this.cocktailIngredients,
    required this.category,
    required this.glassType,
    required this.preparationMethod,
    this.imageUrl,
    required this.alcoholic,
  });

  factory Cocktail.fromJson(Map<String, dynamic> json) {
    return Cocktail(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      cocktailIngredients: (json['cocktailIngredients'] as List<dynamic>?)
          ?.map((item) => CocktailIngredient.fromJson(item))
          .toList() ??
          [],
      category: json['category'] ?? '',
      glassType: json['glassType'] ?? '',
      preparationMethod: json['preparationMethod'] ?? '',
      imageUrl: json['imageUrl'],
      alcoholic: json['alcoholic'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'cocktailIngredients':
      cocktailIngredients.map((item) => item.toJson()).toList(),
      'category': category,
      'glassType': glassType,
      'preparationMethod': preparationMethod,
      'imageUrl': imageUrl,
      'alcoholic': alcoholic,
    };
  }
}
