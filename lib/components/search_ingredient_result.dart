import 'package:flutter/material.dart';
import '../model/ingredient.dart';
import '../screens/ingredient_screen.dart';
import '../theme/app_colors.dart';
import '../utils/ingredient_images.dart';

class SearchIngredientResults extends StatelessWidget {
  final List<Ingredient> ingredients;

  const SearchIngredientResults({
    super.key,
    required this.ingredients,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (ingredients.length * 56)
          .clamp(0, 250)
          .toDouble(),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.tapBarBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black12,
            ),
          ],
        ),
        child: ListView.separated(
          itemCount: ingredients.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final ingredient = ingredients[index];

            return ListTile(
              leading: Image.asset(
                IngredientImages.getImage(ingredient.name),
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
              title: Text(
                ingredient.name,
                style: const TextStyle(
                  fontFamily: 'Gabarito',
                  color: Colors.white,
                ),
              ),
              onTap: () {
                FocusScope.of(context).unfocus();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => IngredientScreen(
                      ingredient: ingredient.name,
                      cocktails: const [],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
