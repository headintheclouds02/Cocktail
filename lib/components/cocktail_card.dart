import 'package:flutter/material.dart';
import 'package:flutter_cocktail/model/cocktail_ingredient.dart';
import '../screens/detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';

class CocktailCard extends StatelessWidget {
  final Image? image;
  final String? imageUrl;
  final Color color;
  final String text;
  final String description;
  final String preparationMethod;
  final String glassType;
  final List<CocktailIngredient> ingredients;
  final bool isFavorite;
  final int cocktailId;

  const CocktailCard({
    super.key,
    this.image,
    this.imageUrl,
    required this.color,
    required this.text,
    required this.description,
    required this.ingredients,
    required this.preparationMethod,
    required this.glassType,
    required this.isFavorite,
    required this.cocktailId,
  });

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final currentIsFavorite = favoriteProvider.isFavorite(cocktailId);

    // Qui creiamo il widget immagine con dimensioni e allineamento fissi, sempre con lo stesso offset
    Widget imageWidget;

    if (image != null) {
      imageWidget = image!;
    } else if (imageUrl != null) {
      imageWidget = Image.network(
        imageUrl!,
        width: 180,
        height: 220,
        fit: BoxFit.cover,
        alignment: Alignment.bottomLeft,
      );
    } else {
      imageWidget = Image.asset(
        'assets/img/placeholder.png',
        width: 180,
        height: 220,
        fit: BoxFit.cover,
        alignment: Alignment.bottomLeft,
      );
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              cocktailId: cocktailId,
              name: text,
              description: description,
              ingredients: ingredients,
              image: imageWidget is Image ? imageWidget as Image : Image.asset('assets/img/placeholder.png'),
              preparationMethod: preparationMethod,
              glassType: glassType,
              isFavorite: currentIsFavorite,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              color: color,
              child: SizedBox(
                width: 130,
                height: 180,
                child: Stack(
                  children: [
                    Transform.translate(
                      offset: const Offset(-15, 5), // mantiene l'effetto spostamento
                      child: imageWidget,
                    ),

                    Positioned(
                      top: -5,
                      right: -5,
                      child: IconButton(
                        icon: Icon(
                          currentIsFavorite ? Icons.favorite : Icons.favorite_border,
                          color: currentIsFavorite ? Colors.red : Colors.black,
                          size: 20,
                        ),
                        onPressed: () async {
                          try {
                            await favoriteProvider.toggleFavorite(cocktailId);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Errore durante l\'aggiornamento dei preferiti')),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                text,
                style: const TextStyle(fontFamily: 'Gabarito', fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
