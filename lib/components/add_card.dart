import 'package:flutter/material.dart';

class AddCard extends StatelessWidget {
  final String title;
  final String description;

  const AddCard({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Text(title, style: TextStyle(fontFamily: 'Gabarito', fontSize: 20)),
          Text(description, style: TextStyle(fontFamily: 'Gabarito', fontSize: 20)),
        ]
      )
    );
  }
}
