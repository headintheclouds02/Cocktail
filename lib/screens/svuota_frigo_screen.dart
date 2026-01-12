import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import '../components/category_card.dart';
import '../model/cocktail.dart';
import '../model/ingredient.dart';

import '../providers/cocktail_provider.dart';

import '../utils/ingredient_colors.dart';
import '../utils/ingredient_images.dart';

import 'ingredient_screen.dart';

class SvuotaFrigoScreen extends StatefulWidget {
  final String title;

  const SvuotaFrigoScreen({super.key, required this.title});

  @override
  State<SvuotaFrigoScreen> createState() => _SvuotaFrigoScreenState();
}

class _SvuotaFrigoScreenState extends State<SvuotaFrigoScreen> {
  Map<String, List<Ingredient>> ingredientsByCategory = {};
  List<String> categories = [];

  String? selectedCategory;
  List<Ingredient> visibleIngredients = [];

  @override
  void initState() {
    super.initState();
    fetchIngredients();
  }

  void fetchIngredients() async {
    final dio = Dio();

    try {
      final response = await dio.get(
        'http://10.0.2.2:8081/api/ingredients/grouped-by-category',
      );

      final Map<String, dynamic> data = response.data;
      final Map<String, List<Ingredient>> parsed = {};

      data.forEach((category, list) {
        parsed[category] = (list as List)
            .map((json) => Ingredient.fromJson(json))
            .toList();
      });

      setState(() {
        ingredientsByCategory = parsed;
        categories = parsed.keys.toList();

        selectedCategory = categories.isNotEmpty ? categories.first : null;
        visibleIngredients = selectedCategory != null
            ? ingredientsByCategory[selectedCategory]!
            : [];
      });
    } catch (e) {
      debugPrint('Errore fetchIngredients → $e');
    }
  }

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
      visibleIngredients = ingredientsByCategory[category] ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final cocktailProvider = context.watch<CocktailProvider>();
    final cocktails = cocktailProvider.cocktails;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontFamily: 'Gabarito', fontSize: 32),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const Text(
              "Quale ingrediente domina il tuo frigo?",
              style: TextStyle(fontFamily: 'Gabarito', fontSize: 18),
            ),
            const SizedBox(height: 16),

            ...categories.map((category) {
              final ingredients = ingredientsByCategory[category] ?? [];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: const TextStyle(
                      fontFamily: 'Gabarito',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 160,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: ingredients.length,
                      itemBuilder: (context, index) {
                        final ingredient = ingredients[index];

                        return CategoryCard(
                          image: Image.asset(
                            IngredientImages.getImage(ingredient.name),
                          ),
                          color: IngredientColors.getColor(ingredient.name),
                          text: ingredient.name,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => IngredientScreen(
                                  ingredient: ingredient.name,
                                  cocktails: cocktails,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
