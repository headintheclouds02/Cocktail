import 'ingredient.dart';

class CocktailIngredient {
  final int id;
  final Ingredient ingredient;
  final String quantity;

  CocktailIngredient({
    required this.id,
    required this.ingredient,
    required this.quantity,
  });

  factory CocktailIngredient.fromJson(Map<String, dynamic> json) {
    return CocktailIngredient(
      id: json['id'],
      ingredient: Ingredient.fromJson(json['ingredient']),
      quantity: json['quantity'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ingredient': ingredient.toJson(),
      'quantity': quantity,
    };
  }
}
