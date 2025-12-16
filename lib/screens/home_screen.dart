import 'package:flutter/material.dart';
import 'package:flutter_cocktail/components/custom_tapbar.dart';
import '../components/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _State();
}

class _State extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Benvenuto!', style: TextStyle(fontFamily: 'Gabarito', fontSize: 32)),
        centerTitle: false,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        children: [
          CustomButton(text: 'Crea il tuo cocktail', onPressed: () {}),
        ],
      ),
      bottomNavigationBar: CustomTapbar(),
    );
  }
}
