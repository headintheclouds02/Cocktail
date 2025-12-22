import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_cocktail/utils/ingredient_colors.dart';
import 'package:flutter_cocktail/utils/ingredient_images.dart';
import '../components/category_card.dart';
import '../model/ingredient.dart';
import '../theme/app_colors.dart';

class SvuotaFrigoScreen extends StatefulWidget {
  final String title;

  const SvuotaFrigoScreen({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SvuotaFrigoScreen> {
  Map<String, List<Ingredient>> ingredientsByCategory = {};
  List<String> categories = [];

  String? selectedCategory;
  List<Ingredient> visibleIngredients = [];

  @override
  void initState() {
    super.initState();
    fetchIngredients();
  }

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
      visibleIngredients = ingredientsByCategory[category] ?? [];
    });
  }

  void fetchIngredients() async {
    final dio = Dio();

    try {
      final response = await dio.get(
        'http://10.0.2.2:8081/api/ingredients/grouped-by-category',
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;

        final Map<String, List<Ingredient>> parsedData = {};

        data.forEach((category, ingredientsList) {
          parsedData[category] = (ingredientsList as List)
              .map((json) => Ingredient.fromJson(json))
              .toList();
        });

        setState(() {
          ingredientsByCategory = parsedData;
          categories = parsedData.keys.toList();

          selectedCategory = categories.isNotEmpty ? categories.first : null;
          visibleIngredients = selectedCategory != null
              ? ingredientsByCategory[selectedCategory]!
              : [];
        });
      }
    } catch (e) {
      debugPrint("Errore fetchIngredients ---> $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontFamily: 'Gabarito', fontSize: 32),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            Text(
              "Quale ingrediente domina il tuo frigo?",
              style: TextStyle(fontFamily: 'Gabarito', fontSize: 18),
            ),
            const SizedBox(height: 16),
            // Qui creo un carosello per ogni categoria
            ...categories.map((category) {
              final ingredients = ingredientsByCategory[category] ?? [];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: TextStyle(
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
                          image: Image.asset(IngredientImages.getImage(ingredient.name)),
                          color:IngredientColors.getColor(ingredient.name),
                          text: ingredient.name,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

}
