import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../components/category_card.dart';
import '../components/search_bar.dart';
import '../components/search_ingredient_result.dart';

import '../model/ingredient.dart';
import '../providers/cocktail_provider.dart';

import '../theme/app_colors.dart';
import '../utils/category_colors.dart';
import '../utils/category_images.dart';
import '../utils/ingredient_colors.dart';
import '../utils/ingredient_images.dart';

import 'category_screen.dart';
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

  bool isSearching = false;
  List<Ingredient> filteredIngredients = [];

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchIngredients();
  }

  void onSearchChanged(String value, List<Ingredient> allIngredients) {
    setState(() {
      isSearching = value.trim().isNotEmpty;
      filteredIngredients = allIngredients
          .where(
            (i) => i.name.toLowerCase().contains(value.toLowerCase()),
      )
          .toList();
    });
  }

  Future<void> fetchIngredients() async {
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
      });
    } catch (e) {
      debugPrint('Errore fetchIngredients → $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final cocktailProvider = context.watch<CocktailProvider>();
    final cocktails = cocktailProvider.cocktails;

    final allIngredients =
    ingredientsByCategory.values.expand((e) => e).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontFamily: 'Gabarito', fontSize: 32),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus();
          setState(() {
            isSearching = false;
            filteredIngredients.clear();
          });
        },
        child: cocktailProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Stack(
          children: [
            ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const SizedBox(height: 16),
                const Text(
                  "Quale ingrediente domina il tuo frigo?",
                  style:
                  TextStyle(fontFamily: 'Gabarito', fontSize: 18),
                ),
                const SizedBox(height: 16),

                CustomSearchBar(
                  controller: searchController,
                  hintText: 'Cerca un ingrediente',
                  icon: SvgPicture.asset(
                    'assets/img/icone/search.svg',
                    color: AppColors.fieldText,
                  ),
                  onChanged: (value) =>
                      onSearchChanged(value, allIngredients),
                ),

                const SizedBox(height: 24),

                ...categories.map((category) {
                  final ingredients =
                      ingredientsByCategory[category] ?? [];

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
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 160,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: ingredients.length,
                          itemBuilder: (context, index) {
                            final ingredient = ingredients[index];

                            return CategoryCard(
                              image: Image.asset(
                                IngredientImages.getImage(
                                    ingredient.name),
                              ),
                              color: IngredientColors.getColor(
                                  ingredient.name),
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
                      const SizedBox(height: 32),
                    ],
                  );
                }),
              ],
            ),

            // 🔼 OVERLAY RISULTATI SEARCH
            if (isSearching)
              Positioned(
                top: 120, // sotto la search bar
                left: 16,
                right: 16,
                child: SearchIngredientResults(
                  ingredients: filteredIngredients,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
