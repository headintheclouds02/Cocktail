import 'package:flutter/material.dart';
import 'package:flutter_cocktail/model/cocktail_ingredient.dart';
import '../screens/detail_screen.dart';

class CocktailCard extends StatefulWidget {
  final Image image;
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
    required this.image,
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
  State<CocktailCard> createState() => _CocktailCardState();
}

class _CocktailCardState extends State<CocktailCard> {
  late bool _isFavorite;
  //bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              cocktailId: widget.cocktailId,
              name: widget.text,
              description: widget.description,
              ingredients: widget.ingredients,
              image: widget.image,
              preparationMethod: widget.preparationMethod,
              glassType: widget.glassType,
              isFavorite: widget.isFavorite,
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
              color: widget.color,
              child: SizedBox(
                width: 130,
                height: 180,
                child: Stack(
                  children: [
                    Transform.translate(
                      offset: const Offset(-15, 5),
                      child: widget.image,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                widget.text,
                style: const TextStyle(fontFamily: 'Gabarito', fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}