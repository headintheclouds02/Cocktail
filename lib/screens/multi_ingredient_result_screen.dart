import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/cocktail_card.dart';
import '../model/cocktail.dart';
import '../providers/cocktail_provider.dart';
import '../providers/favorite_provider.dart';
import '../utils/cocktail_images.dart';

class MultiIngredientResultScreen extends StatelessWidget {
  final List<String> selectedIngredients;
  final baseUrl = 'http://10.0.2.2:8081';


  const MultiIngredientResultScreen({
    super.key,
    required this.selectedIngredients,
  });

  String _normalize(String value) {
    return value.toLowerCase().trim();
  }

  Widget _buildCocktailCard(
    BuildContext context,
    Cocktail cocktail,
    Color color,
  ) {
    final hasRemoteImage =
        cocktail.imageUrl != null && cocktail.imageUrl!.isNotEmpty;
    return CocktailCard(
      cocktailId: cocktail.id,
      text: cocktail.name,
      description: cocktail.description,
      ingredients: cocktail.cocktailIngredients,
      preparationMethod: cocktail.preparationMethod,
      glassType: cocktail.glassType,
      color: color,
      isFavorite: context.read<FavoriteProvider>().isFavorite(cocktail.id),

      imageUrl: hasRemoteImage ? baseUrl + cocktail.imageUrl! : null,
      image: !hasRemoteImage
          ? Image.asset(CocktailImages.getImage(cocktail.name))
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cocktails = context.watch<CocktailProvider>().cocktails;

    final normalizedSelectedIngredients = selectedIngredients
        .map(_normalize)
        .toSet();

    final fullMatchCocktails = normalizedSelectedIngredients.isEmpty
        ? <Cocktail>[]
        : cocktails.where((cocktail) {
            final cocktailIngredientSet = cocktail.cocktailIngredients
                .map((ci) => _normalize(ci.ingredient.name))
                .toSet();

            final isFullMatch = normalizedSelectedIngredients.every(
              cocktailIngredientSet.contains,
            );

            return isFullMatch;
          }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Risultati',
          style: TextStyle(fontFamily: 'Gabarito', fontSize: 32),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        children: [
          Text(
            'Match al 100% (${fullMatchCocktails.length})',
            style: const TextStyle(
              fontFamily: 'Gabarito',
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          if (fullMatchCocktails.isEmpty)
            const Text(
              'Nessun cocktail con tutti gli ingredienti.',
              style: TextStyle(fontFamily: 'Gabarito', fontSize: 18),
            )
          else
            ...fullMatchCocktails.map(
              (c) => _buildCocktailCard(context, c, Colors.white),
            ),

          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 16),

          ...normalizedSelectedIngredients.map((ingredientName) {
            final cocktailsWithSingleIngredient = cocktails.where((cocktail) {
              final cocktailIngredientSet = cocktail.cocktailIngredients
                  .map((ci) => _normalize(ci.ingredient.name))
                  .toSet();

              return cocktailIngredientSet.contains(ingredientName);
            }).toList();

            if (cocktailsWithSingleIngredient.isEmpty) {
              return const SizedBox.shrink();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Con solo $ingredientName puoi realizzare:',
                  style: const TextStyle(
                    fontFamily: 'Gabarito',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                ...cocktailsWithSingleIngredient.map(
                  (c) => _buildCocktailCard(context, c, Colors.grey.shade100),
                ),
                const SizedBox(height: 24),
              ],
            );
          }),
        ],
      ),
    );
  }
}
