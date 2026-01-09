import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AddCard extends StatelessWidget {
  final String title;
  final String description;
  final Function onTap;

  const AddCard({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.symmetric(vertical: 30),
        color: AppColors.addCard,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(fontFamily: 'Gabarito', fontSize: 25),
                textAlign: TextAlign.center,
              ),
              Text(
                description,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
