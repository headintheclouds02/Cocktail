import 'package:flutter/material.dart';
import 'package:flutter_cocktail/providers/cocktail_provider.dart';
import 'package:provider/provider.dart';
import '../components/cocktail_card.dart';
import '../model/cocktail.dart';
import '../providers/auth_api_provider.dart';
import '../providers/favorite_provider.dart';
import '../utils/cocktail_colors.dart';
import '../utils/cocktail_images.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
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

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 3 / 4,
      // Numero di colonne
      padding: EdgeInsets.all(10),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: List.generate(cocktails.length, (index) {
        return CocktailCard(
          image: Image.asset(CocktailImages.getImage(cocktails[index].name)),
          color: CocktailColors.getColor(cocktails[index].name),
          text: cocktails[index].name,
          description: cocktails[index].description,
          ingredients: cocktails[index].cocktailIngredients,
          preparationMethod: cocktails[index].preparationMethod,
          glassType: cocktails[index].glassType,
          isFavorite: favoriteProvider.isFavorite(cocktails[index].id),
          cocktailId: cocktails[index].id,
        );
      }),
    );
  }
}
