import 'cocktail_ingredient.dart';
import 'ingredient.dart';

class IngredientEntry {
  String quantity;
  String category;
  String unit;
  String name;
  String description;


  IngredientEntry({
    this.quantity = '',
    this.unit = 'ml',
    this.name = '',
    this.category = '',
    this.description = '',
  });
}
extension IngredientEntryMapper on IngredientEntry{

  CocktailIngredient toCocktailIngredient() {
    final ingr = Ingredient(
      id: 0,
      name: name,
      category: category,
      unit: unit,
      description: description.isEmpty ? null : description,
    );

    return CocktailIngredient(
      id: 0,
      ingredient: ingr,
      quantity: quantity,
    );
  }
}
