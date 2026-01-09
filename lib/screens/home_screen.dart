import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_cocktail/components/category_card.dart';
import 'package:flutter_cocktail/components/cocktail_card.dart';
import 'package:flutter_cocktail/providers/cocktail_provider.dart';
import 'package:flutter_cocktail/utils/category_colors.dart';
import 'package:flutter_cocktail/utils/category_images.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../components/custom_button.dart';
import '../components/search_bar.dart';
import '../model/cocktail.dart';
import '../providers/favorite_provider.dart';
import '../theme/app_colors.dart';
import '../utils/cocktail_colors.dart';
import '../utils/cocktail_images.dart';
import 'category_screen.dart';
import 'detail_screen.dart';


class HomeScreen extends StatefulWidget {
  final Function(int) onChangePage;

  const HomeScreen({super.key, required this.onChangePage});

  @override
  State<HomeScreen> createState() => _State();
}

class _State extends State<HomeScreen> {
  List<Cocktail> cocktails = [];

  final TextEditingController searchController = TextEditingController();
  List<Cocktail> filteredCocktails = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    fetchCocktails();
  }

  void onSearchChanged(String value) {
    setState(() {
      isSearching = value.trim().isNotEmpty;

      filteredCocktails = cocktails
          .where(
            (c) => c.name.toLowerCase().contains(
          value.toLowerCase(),
        ),
      )
          .toList();
    });
  }


  void fetchCocktails() async {
    final apiProvider = Provider.of<CocktailProvider>(context, listen: false);

    try {
      final fetchedCocktails = await apiProvider.fetchCocktails();
      setState(() {
        cocktails = fetchedCocktails;
        filteredCocktails = fetchedCocktails;
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
    final baseUrl = 'http://10.0.2.2:8081';


    final uniqueCategories = cocktails.map((c) => c.category).toSet().toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),

      child: ListView(
        children: [

          CustomSearchBar(
            controller: searchController,
            hintText: 'Cerca un cocktail',
            icon: SvgPicture.asset(
              'assets/icons/search.svg',
              color:
                AppColors.fieldText,
            ),
            onChanged: onSearchChanged,
          ),

          SizedBox(height: 16),

          if (isSearching)
            Container(
              constraints: const BoxConstraints(maxHeight: 250),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black12,
                  ),
                ],
              ),


              child: ListView.separated(
                shrinkWrap: true,
                itemCount: filteredCocktails.length,
                separatorBuilder: (_, __) => Divider(height: 1),
                itemBuilder: (context, index) {
                  final cocktail = filteredCocktails[index];

                  return ListTile(
                    title: Text(cocktail.name),
                    onTap: () {
                      FocusScope.of(context).unfocus();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(
                            name: filteredCocktails[index].name,
                            description: filteredCocktails[index].description,
                            ingredients: filteredCocktails[index].cocktailIngredients,
                            preparationMethod: filteredCocktails[index].preparationMethod,
                            glassType: filteredCocktails[index].glassType,
                            image: Image.asset(
                              CocktailImages.getImage(filteredCocktails[index].name),
                            ),
                            cocktailId: filteredCocktails[index].id,
                            isFavorite: favoriteProvider.isFavorite(filteredCocktails[index].id),
                          ),
                        ),
                      );

                      searchController.clear();
                      setState(() => isSearching = false);
                    },
                  );
                },
              ),
            ),

          if (isSearching && filteredCocktails.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Nessun cocktail trovato',
                style: TextStyle(color: Colors.grey),
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

                  imageUrl: (cocktails[index].imageUrl != null && cocktails[index].imageUrl!.isNotEmpty)
                      ? baseUrl + cocktails[index].imageUrl!
                      : null,
                  image: (cocktails[index].imageUrl == null || cocktails[index].imageUrl!.isEmpty)
                      ? Image.asset(CocktailImages.getImage(cocktails[index].name))
                      : null,
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