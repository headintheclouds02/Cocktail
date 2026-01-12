import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/cocktail_card.dart';
import '../providers/cocktail_provider.dart';
import '../providers/favorite_provider.dart';

import '../utils/cocktail_colors.dart';
import '../utils/cocktail_images.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<CocktailProvider>().fetchCocktails();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cocktailProvider = context.watch<CocktailProvider>();
    final favoriteProvider = context.watch<FavoriteProvider>();

    final cocktails = cocktailProvider.cocktails;
    final baseUrl = 'http://10.0.2.2:8081';

    if (cocktailProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 3 / 4,
      padding: const EdgeInsets.all(10),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: List.generate(cocktails.length, (index) {
        final cocktail = cocktails[index];

        return CocktailCard(
          imageUrl:
          cocktail.imageUrl != null && cocktail.imageUrl!.isNotEmpty
              ? baseUrl + cocktail.imageUrl!
              : null,
          image:
          cocktail.imageUrl == null || cocktail.imageUrl!.isEmpty
              ? Image.asset(
            CocktailImages.getImage(cocktail.name),
          )
              : null,
          color: CocktailColors.getColor(cocktail.name),
          text: cocktail.name,
          description: cocktail.description,
          ingredients: cocktail.cocktailIngredients,
          preparationMethod: cocktail.preparationMethod,
          glassType: cocktail.glassType,
          isFavorite: favoriteProvider.isFavorite(cocktail.id),
          cocktailId: cocktail.id,
        );
      }),
    );
  }
}
