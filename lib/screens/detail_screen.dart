import 'package:flutter/material.dart';
import 'package:flutter_cocktail/model/cocktail_ingredient.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';

class DetailScreen extends StatefulWidget {
  final String name;
  final String description;
  final List<CocktailIngredient> ingredients;
  final Image image;
  final String preparationMethod;
  final String glassType;
  final int cocktailId;
  final bool isFavorite;

  const DetailScreen({
    super.key,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.image,
    required this.preparationMethod,
    required this.glassType,
    required this.isFavorite,
    required this.cocktailId,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  void _toggleFavorite() async {
    final favoriteProvider = Provider.of<FavoriteProvider>(
      context,
      listen: false,
    );

    try {
      await favoriteProvider.toggleFavorite(widget.cocktailId);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error during updating favorites')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final isFavorite = favoriteProvider.isFavorite(widget.cocktailId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(fontFamily: 'Gabarito', fontSize: 32),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: _toggleFavorite,
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //IMMAGINE
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 350,
                maxWidth: double.infinity,
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: widget.image,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),

              //TEXT "INGREDIENTI"
              child: Text(
                "Ingredienti",
                style: TextStyle(fontFamily: 'Gabarito', fontSize: 28),
                textAlign: TextAlign.start,
              ),
            ),

            //TESTI INGREDIENTI, DINAMICO IN BASE AL NUMERO DI INGREDIENTI
            for (var ingredient in widget.ingredients)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,

                children: [
                  Row(
                    children: [
                      Text(
                        "${ingredient.quantity}  ",
                        style: TextStyle(fontFamily: 'Gabarito', fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        ingredient.ingredient.name,
                        style: TextStyle(fontFamily: 'Gabarito', fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                //TEXT "DESCRIZIONE"
                child: Text(
                  "Descrizione",
                  style: TextStyle(fontFamily: 'Gabarito', fontSize: 28),
                  textAlign: TextAlign.start,
                ),
              ),
            ),

            //TESTO DI DESCRIZIONE
            Text(
              widget.description,
              style: TextStyle(fontFamily: 'Gabarito', fontSize: 18),
              //textAlign: TextAlign.center,
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                //TEXT "PROCEDIMENTO"
                child: Text(
                  "Procedimento",
                  style: TextStyle(fontFamily: 'Gabarito', fontSize: 28),
                  textAlign: TextAlign.start,
                ),
              ),
            ),

            //TESTO DI DESCRIZIONE
            Text(
              widget.preparationMethod,
              style: TextStyle(fontFamily: 'Gabarito', fontSize: 18),
              //textAlign: TextAlign.center,
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                //TEXT "BICCHIERE"
                child: Text(
                  "Tipo di bicchiere",
                  style: TextStyle(fontFamily: 'Gabarito', fontSize: 28),
                  textAlign: TextAlign.start,
                ),
              ),
            ),

            //TESTO DI DESCRIZIONE
            Text(
              widget.glassType,
              style: TextStyle(fontFamily: 'Gabarito', fontSize: 18),
              //textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
