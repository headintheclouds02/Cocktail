import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CategoryCard extends StatelessWidget {
  final Image image;
  final Color color;
  final String text;

  const CategoryCard({
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
      borderRadius: BorderRadius.circular(100),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.symmetric(horizontal: 16),
              color: color,
              shape: const CircleBorder(),
              child: SizedBox(
                width: 80,
                height: 80,
                child: Transform.translate(
                  offset: const Offset(-15, 5),
                  child: image,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                text,
                style: TextStyle(fontFamily: 'Gabarito', fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
