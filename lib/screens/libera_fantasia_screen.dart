import 'package:flutter/material.dart';

class LiberaFantasiaScreen extends StatelessWidget {
  final String title;
  const LiberaFantasiaScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(fontFamily: 'Gabarito', fontSize: 32)),
      )

    );
  }
}
