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
    const baseUrl = 'http://10.0.2.2:8081';

    return SizedBox(
      height: (cocktails.length * 56).clamp(0, 250).toDouble(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(blurRadius: 10, color: Colors.black12)],
        ),
        child: ListView.separated(
          itemCount: cocktails.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final cocktail = cocktails[index];

            final Image image =
                cocktail.imageUrl != null && cocktail.imageUrl!.isNotEmpty
                ? Image.network(baseUrl + cocktail.imageUrl!, fit: BoxFit.cover)
                : Image.asset(
                    CocktailImages.getImage(cocktail.name),
                    fit: BoxFit.cover,
                  );

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
                      image: image,
                      cocktailId: cocktail.id,
                      isFavorite: favoriteProvider.isFavorite(cocktail.id),
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
