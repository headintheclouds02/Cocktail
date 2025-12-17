import 'package:flutter/material.dart';

import '../components/cocktail_card.dart';
import '../theme/app_colors.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Esplora',
            style: TextStyle(fontFamily: 'Gabarito', fontSize: 32),
          ),
          centerTitle: false,
        ),
        body: InkWell(
          onTap: () {
            // Azione al tap
          },
          child: GridView.count(
            crossAxisCount: 3,
            // Numero di colonne
            padding: EdgeInsets.all(10),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: List.generate(20, (index) {
              return Container(
                color: Colors.blueAccent,
                child: Center(
                  child: Text(
                    'Item $index',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
