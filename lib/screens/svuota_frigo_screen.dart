import 'package:flutter/material.dart';


class SvuotaFrigoScreen extends StatelessWidget {
  final String title;
  const SvuotaFrigoScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title, style: TextStyle(fontFamily: 'Gabarito', fontSize: 32)),
        )

    );
  }
}
