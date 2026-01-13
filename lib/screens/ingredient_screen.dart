import 'package:flutter/material.dart';
import 'package:flutter_cocktail/screens/libera_fantasia_screen.dart';
import 'package:provider/provider.dart';
import '../components/cocktail_card.dart';
import '../components/custom_button.dart';
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
    final filteredCocktails = cocktails.where(
          (cocktail) => cocktail.cocktailIngredients
          .any((ci) => ci.ingredient.name == ingredient),
    ).toList();

    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    const baseUrl = 'http://10.0.2.2:8081';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          ingredient,
          style: const TextStyle(fontFamily: 'Gabarito', fontSize: 32),
        ),
      ),
      body: filteredCocktails.isEmpty
          ? _EmptyIngredientState(
        ingredient: ingredient,
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Qui puoi trovare tutti i cocktail che contengono: "$ingredient"',
              style: const TextStyle(
                fontFamily: 'Gabarito',
                fontSize: 22,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCocktails.length,
              itemBuilder: (context, index) {
                final cocktail = filteredCocktails[index];
                final Image image =
                cocktail.imageUrl != null &&
                    cocktail.imageUrl!.isNotEmpty
                    ? Image.network(
                  baseUrl + cocktail.imageUrl!,
                  fit: BoxFit.cover,
                )
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
                  isFavorite:
                  favoriteProvider.isFavorite(cocktail.id),
                  cocktailId: cocktail.id,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}


class _EmptyIngredientState extends StatelessWidget {
  final String ingredient;

  const _EmptyIngredientState({
    required this.ingredient,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.local_bar_outlined,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 24),
            Text(
              'Non esistono cocktail\ncon "$ingredient"',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Gabarito',
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Ma puoi crearlo tu 🍸',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Gabarito',
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
               child: CustomButton(
                text: 'Crea cocktail',
                onPressed: () {
                  Navigator.push(
                    context,
                      MaterialPageRoute(
                        builder: (_) => const LiberaFantasiaScreen(),
                      ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

