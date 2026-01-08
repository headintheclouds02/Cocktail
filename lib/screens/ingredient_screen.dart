import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/cocktail_card.dart';
import '../model/cocktail.dart';
import '../providers/favorite_provider.dart';
import '../utils/cocktail_colors.dart';
import '../utils/cocktail_images.dart';

class IngredientScreen extends StatelessWidget {
  final String ingredient;
  final List<Cocktail> cocktails;

  const IngredientScreen({
    super.key,
    required this.ingredient,
    required this.cocktails,
  });

  @override
  Widget build(BuildContext context) {
    final filteredCocktails = cocktails.where((cocktail) =>
        cocktail.cocktailIngredients.any((ci) => ci.ingredient.name == ingredient)
    ).toList();

    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(ingredient, style: TextStyle(fontFamily: 'Gabarito', fontSize: 32)),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Qui puoi trovare tutti i cocktail che contengono:  "$ingredient"',
                style: TextStyle(fontFamily: 'Gabarito', fontSize: 22),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredCocktails.length,
                itemBuilder: (context, index) {
                  final cocktail = filteredCocktails[index];
                  return CocktailCard(
                    image: Image.asset(
                      CocktailImages.getImage(cocktail.name),
                    ),
                    color: CocktailColors.getColor(cocktail.name),
                    text: cocktail.name,
                    description: cocktail.description,
                    ingredients: cocktail.cocktailIngredients,
                    preparationMethod: cocktail.preparationMethod,
                    glassType: cocktail.glassType,
                    isFavorite: favoriteProvider.isFavorite(cocktail.id),
                    cocktailId: cocktail.id,
                  );
                },
              ),
            ),
          ]
      ),
    );
  }
}
