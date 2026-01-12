import 'package:flutter/material.dart';

import '../model/cocktail.dart';
import '../providers/favorite_provider.dart';
import '../screens/detail_screen.dart';
import '../utils/cocktail_images.dart';

class SearchResults extends StatelessWidget {
  final List<Cocktail> cocktails;
  final FavoriteProvider favoriteProvider;

  const SearchResults({
    required this.cocktails,
    required this.favoriteProvider,
  });

  @override
  Widget build(BuildContext context) {
    const double itemHeight = 56;
    const double maxHeight = 250;

    final height = (cocktails.length * itemHeight)
        .clamp(0, maxHeight)
        .toDouble();

    return SizedBox(
      height: height,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(blurRadius: 10, color: Colors.black12),
          ],
        ),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: cocktails.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final cocktail = cocktails[index];

            return ListTile(
              title: Text(cocktail.name),
              onTap: () {
                FocusScope.of(context).unfocus();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailScreen(
                      name: cocktail.name,
                      description: cocktail.description,
                      ingredients: cocktail.cocktailIngredients,
                      preparationMethod: cocktail.preparationMethod,
                      glassType: cocktail.glassType,
                      image: Image.asset(
                        CocktailImages.getImage(cocktail.name),
                      ),
                      cocktailId: cocktail.id,
                      isFavorite:
                      favoriteProvider.isFavorite(cocktail.id),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

