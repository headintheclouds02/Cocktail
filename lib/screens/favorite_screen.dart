import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/cocktail_card.dart';
import '../providers/favorite_provider.dart';
import '../utils/cocktail_colors.dart';
import '../utils/cocktail_images.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final baseUrl = 'http://10.0.2.2:8081';


    if (favoriteProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final favorites = favoriteProvider.favorites;

    if (favorites.isEmpty) {
      return const Center(child: Text("Nessun preferito trovato."));
    }

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 3 / 4,
      padding: const EdgeInsets.all(10),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: List.generate(favorites.length, (index) {
        final favorite = favorites[index];

        return CocktailCard(
          cocktailId: favorite.cocktail.id,
          imageUrl: (favorite.cocktail.imageUrl != null && favorite.cocktail.imageUrl!.isNotEmpty)
              ? baseUrl + favorite.cocktail.imageUrl!
              : null,
          image: (favorite.cocktail.imageUrl == null || favorite.cocktail.imageUrl!.isEmpty)
              ? Image.asset(CocktailImages.getImage(favorite.cocktail.name))
              : null,
          color: CocktailColors.getColor(favorite.cocktail.name),
          text: favorite.cocktail.name,
          description: favorite.cocktail.description,
          ingredients: favorite.cocktail.cocktailIngredients,
          preparationMethod: favorite.cocktail.preparationMethod,
          glassType: favorite.cocktail.glassType,
          isFavorite: true,
        );
      }),
    );
  }
}
