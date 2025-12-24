import 'package:flutter/material.dart';
import 'package:flutter_cocktail/components/cocktail_card.dart';
import 'package:flutter_cocktail/components/custom_button.dart';
import 'menu_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text("Benvenuto nella tua area personale!", style: TextStyle(fontFamily: 'Gabarito', fontSize: 26)),
          ),
          Spacer(),
          Text("I creati da te:", textAlign: TextAlign.left, style: TextStyle(fontFamily: 'Gabarito', fontSize: 32)),
          CocktailCard(image: Image.asset("assets/img/cocktail/bloody.png"), color: Colors.red, text: "Prova", description: "short description just to try the card", ingredients: [], preparationMethod: "no idea", glassType: "sex on the beach", isFavorite: false, cocktailId: 9),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: CustomButton(text: 'Logout', onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MenuScreen()),
                    (route) => false,
              );
            }),
          ),
        ],
      ),
    );
  }
}
