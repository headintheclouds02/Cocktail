import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_cocktail/components/category_card.dart';
import 'package:flutter_cocktail/components/cocktail_card.dart';
import 'package:flutter_cocktail/providers/cocktail_provider.dart';
import 'package:flutter_cocktail/utils/category_colors.dart';
import 'package:flutter_cocktail/utils/category_images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../components/custom_button.dart';
import '../components/search_bar.dart';
import '../model/cocktail.dart';
import '../providers/favorite_provider.dart';
import '../theme/app_colors.dart';
import '../utils/cocktail_colors.dart';
import '../utils/cocktail_images.dart';
import 'category_screen.dart';

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
    final apiProvider = Provider.of<CocktailProvider>(context, listen: false);

    try {
      final fetchedCocktails = await apiProvider.fetchCocktails();
      setState(() {
        cocktails = fetchedCocktails;
      });
    } catch (e) {
      if (e.toString().contains('Session expired')) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Session expired, login.')),
        );
        Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    // 🔥 CATEGORIE UNICHE
    final uniqueCategories = cocktails.map((c) => c.category).toSet().toList();

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

          //CAROSELLO CARD COCKTAIL (FIX DUPLICATI)
          SizedBox(
            height: 160,
            child: ListView.builder(
              itemCount: uniqueCategories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final category = uniqueCategories[index];
                return CategoryCard(
                  image: Image.asset(
                    CategoryImages.getImage(category),
                  ),
                  color: CategoryColors.getColor(category),
                  text: category,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryScreen(
                          category: category,
                          cocktails: cocktails,
                        ),
                      ),
                    );
                  },
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
                  image: Image.asset(
                    CocktailImages.getImage(cocktails[index].name),
                  ),
                  color: CocktailColors.getColor(cocktails[index].name),
                  text: cocktails[index].name,
                  description: cocktails[index].description,
                  ingredients: cocktails[index].cocktailIngredients,
                  preparationMethod: cocktails[index].preparationMethod,
                  glassType: cocktails[index].glassType,
                  isFavorite: favoriteProvider.isFavorite(cocktails[index].id),
                  cocktailId: cocktails[index].id,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}