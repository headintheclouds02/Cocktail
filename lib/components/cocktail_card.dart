import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CocktailCard extends StatelessWidget {
  final Image image;
  final Color color;
  final String text;

  const CocktailCard({
    super.key,
    required this.image,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Azione al tap
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              color: color,
              child: SizedBox(
                width: 130,
                height: 180,
                child: Stack(
                  children: [
                    Transform.translate(
                      offset: const Offset(-15, 5),
                      child: image,
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Icon(
                        Icons.favorite_border,
                        color: AppColors.buttonEnabled,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                text,
                style: const TextStyle(fontFamily: 'Gabarito', fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

