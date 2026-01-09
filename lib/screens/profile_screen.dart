import 'package:flutter/material.dart';
import 'package:flutter_cocktail/components/cocktail_card.dart';
import 'package:flutter_cocktail/components/custom_button.dart';
import 'package:provider/provider.dart';
import '../model/cocktail.dart';
import '../providers/cocktail_provider.dart';
import '../providers/favorite_provider.dart';
import '../utils/cocktail_colors.dart';
import '../utils/cocktail_images.dart';
import 'menu_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Cocktail> createdCocktails = [];

  @override
  void initState() {
    super.initState();
    fetchCocktails();
  }

  void fetchCocktails() async {
    final apiProvider = Provider.of<CocktailProvider>(context, listen: false);

    try {
      final fetchedCocktails = await apiProvider.fetchCocktails();
      final filteredCocktails = fetchedCocktails
          .where((cocktail) => cocktail.category == "Creato da me")
          .toList();
      setState(() {
        createdCocktails = filteredCocktails;
      });
    } catch (e) {
      if (e.toString().contains('Session expired')) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Session expired, login.')),
        );
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil('/login', (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final baseUrl = 'http://10.0.2.2:8081';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              "Benvenuto nella tua area personale!",
              style: TextStyle(fontFamily: 'Gabarito', fontSize: 26),
            ),
          ),

          Spacer(),

          Text(
            "I creati da te:",
            textAlign: TextAlign.left,
            style: TextStyle(fontFamily: 'Gabarito', fontSize: 32),
          ),

          SizedBox(
            height: 250,
            child: createdCocktails.isEmpty
                ? Center(
                    child: Text(
                      "Nessun cocktail creato da te.",
                      style: TextStyle(fontFamily: 'Gabarito', fontSize: 20),
                    ),
                  )
                : ListView.builder(
                    itemCount: createdCocktails.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CocktailCard(
                        imageUrl:
                            (createdCocktails[index].imageUrl != null &&
                                createdCocktails[index].imageUrl!.isNotEmpty)
                            ? baseUrl + createdCocktails[index].imageUrl!
                            : null,
                        image:
                            (createdCocktails[index].imageUrl == null ||
                                createdCocktails[index].imageUrl!.isEmpty)
                            ? Image.asset(
                                CocktailImages.getImage(
                                  createdCocktails[index].name,
                                ),
                              )
                            : null,
                        color: CocktailColors.getColor(
                          createdCocktails[index].name,
                        ),
                        text: createdCocktails[index].name,
                        description: createdCocktails[index].description,
                        ingredients:
                            createdCocktails[index].cocktailIngredients,
                        preparationMethod:
                            createdCocktails[index].preparationMethod,
                        glassType: createdCocktails[index].glassType,
                        isFavorite: favoriteProvider.isFavorite(
                          createdCocktails[index].id,
                        ),
                        cocktailId: createdCocktails[index].id,
                      );
                    },
                  ),
          ),

          Spacer(),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: CustomButton(
              text: 'Logout',
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MenuScreen()),
                  (route) => false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
