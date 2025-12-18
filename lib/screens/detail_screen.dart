import 'package:flutter/material.dart';
import 'package:flutter_cocktail/model/cocktail_ingredient.dart';

class DetailScreen extends StatelessWidget {
  final String name;
  final String description;
  final List<CocktailIngredient> ingredients;

  const DetailScreen({
    super.key,
    required this.name,
    required this.description,
    required this.ingredients,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: TextStyle(fontFamily: 'Gabarito', fontSize: 32),
        ),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //IMMAGINE
            SizedBox(
              width: 400,
              height: 400,
              child: Image.asset('assets/img/cocktail/margarita.png'),
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
            for (var ingredient in ingredients)
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
                  IconButton(
                    onPressed: () {
                      //funzione che permette di mostrare la snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Aggiunto al carrello'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: Icon(Icons.shopping_cart),
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
              description,
              style: TextStyle(fontFamily: 'Gabarito', fontSize: 18),
              //textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
