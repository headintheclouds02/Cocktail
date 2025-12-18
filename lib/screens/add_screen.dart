import 'package:flutter/material.dart';
import 'package:flutter_cocktail/components/add_card.dart';
import 'package:flutter_cocktail/screens/svuota_frigo_screen.dart';

import 'libera_fantasia_screen.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 55),
      child: Column(
        children: [
          Spacer(),
          AddCard(
            title: "Svuota frigo",
            description:
                "Cocktail con quello che hai in casa. Facile e veloce!",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SvuotaFrigoScreen()),
              );
            },
          ),
          AddCard(
            title: "Libera la fantasia",
            description: "Crea il tuo cocktail da zero, senza limiti!",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LiberaFantasiaScreen()),
              );
            },
          ),
          Spacer(),
        ],
      ),
    );
  }
}
