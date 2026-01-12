import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/cocktail_card.dart';
import '../model/cocktail.dart';
import '../providers/favorite_provider.dart';
import '../utils/cocktail_colors.dart';
import '../utils/cocktail_images.dart';

class CategoryScreen extends StatelessWidget {
  final String category;
  final List<Cocktail> cocktails;

  const CategoryScreen({
    super.key,
    required this.category,
    required this.cocktails,
  });

  @override
  Widget build(BuildContext context) {
    final filteredCocktails = cocktails.where((c) => c.category == category).toList();
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    const baseUrl = 'http://10.0.2.2:8081';


    return Scaffold(
      appBar: AppBar(
        title: Text(category, style: TextStyle(fontFamily: 'Gabarito', fontSize: 32)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Qui puoi trovare tutti i cocktail appartenenti alla categoria "$category"',
              style: TextStyle(fontFamily: 'Gabarito', fontSize: 22),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCocktails.length,
              itemBuilder: (context, index) {
                final cocktail = filteredCocktails[index];
                final Image image =
                cocktail.imageUrl != null && cocktail.imageUrl!.isNotEmpty
                    ? Image.network(baseUrl + cocktail.imageUrl!, fit: BoxFit.cover)
                    : Image.asset(
                  CocktailImages.getImage(cocktail.name),
                  fit: BoxFit.cover,
                );

                return CocktailCard(

                  image: image,
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
