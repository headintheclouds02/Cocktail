import 'package:flutter/material.dart';
import 'package:flutter_cocktail/components/add_card.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddCard(title: "Svuota frigo", description: "Cocktail con quello che hai in casa. Facile e veloce!"),
        AddCard(title: "Libera la fantasia", description: "Crea il tuo cocktail da zero, senza limiti!"),
      ],
    );
  }
}