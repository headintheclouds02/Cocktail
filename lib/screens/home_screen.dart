import 'dart:async';
import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_cocktail/components/category_card.dart';
import 'package:flutter_cocktail/components/cocktail_card.dart';
import 'package:flutter_cocktail/utils/category_colors.dart';
import 'package:flutter_cocktail/utils/category_images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/custom_button.dart';
import '../components/search_bar.dart';
import '../model/cocktail.dart';
import '../theme/app_colors.dart';
import 'package:dio/dio.dart';
import '../utils/cocktail_colors.dart';
import '../utils/cocktail_images.dart';

class HomeScreen extends StatefulWidget {
  final Function(int) onChangePage;

  const HomeScreen({super.key, required this.onChangePage});

  @override
  State<HomeScreen> createState() => _State();
}

class _State extends State<HomeScreen> {
  List<Cocktail> cocktails = [];

  @override
  void initState() {
    super.initState();
    fetchCocktails();
  }

  void fetchCocktails() async {
    final dio = Dio();

    try {
      var response = await dio.get('http://10.0.2.2:8081/api/public/cocktails');
      print(response.statusCode);
      List<dynamic> data = response.data['content'];

      print(response);

      setState(() {
        cocktails = data.map((json) => Cocktail.fromJson(json)).toList();
      });
    } catch (e) {
      print("-----> $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: [
          //SEARCH BAR CUSTOM
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: CustomSearchBar(
              hintText: ('Cosa vuoi bere?'),
              onChanged: (value) {},
              icon: SvgPicture.asset(
                'assets/img/icone/search.svg',
                width: 20,
                height: 20,
                color: AppColors.iconFocused,
              ),
            ),
          ),

          //TEXT "CATEGORIES"
          Text(
            "Categorie",
            style: TextStyle(fontFamily: 'Gabarito', fontSize: 22),
          ),

          //CAROSELLO CARD COCKTAIL
          SizedBox(
            height: 160,
            child: ListView.builder(
              itemCount: cocktails.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CategoryCard(
                  image: Image.asset(CategoryImages.getImage(cocktails[index].category)),
                  color: CategoryColors.getColor(cocktails[index].category),
                  text: cocktails[index].category,
                );
              },
            ),
          ),

          //BUTTON CUSTOM
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: CustomButton(
              text: 'Crea il tuo cocktail',
              onPressed: () => widget.onChangePage(2),
            ),
          ),

          //TEXT "POPULAR"
          Text(
            "Popolari",
            style: TextStyle(fontFamily: 'Gabarito', fontSize: 22),
          ),

          SizedBox(
            height: 250,
            child: ListView.builder(
              itemCount: cocktails.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CocktailCard(
                  image: Image.asset(CocktailImages.getImage(cocktails[index].name)),
                  color: CocktailColors.getColor(cocktails[index].name),
                  text: cocktails[index].name,
                  description: cocktails[index].description,
                  ingredients: cocktails[index].cocktailIngredients,
                  preparationMethod: cocktails[index].preparationMethod,
                  glassType: cocktails[index].glassType,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
