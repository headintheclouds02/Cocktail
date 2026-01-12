import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../components/custom_button.dart';
import '../components/search_bar.dart';
import '../components/category_card.dart';
import '../components/cocktail_card.dart';

import '../components/search_result.dart';
import '../model/cocktail.dart';
import '../providers/cocktail_provider.dart';
import '../providers/favorite_provider.dart';

import '../theme/app_colors.dart';
import '../utils/category_colors.dart';
import '../utils/category_images.dart';
import '../utils/cocktail_colors.dart';
import '../utils/cocktail_images.dart';

import 'category_screen.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final Function(int) onChangePage;

  const HomeScreen({super.key, required this.onChangePage});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  bool isSearching = false;
  List<Cocktail> filteredCocktails = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<CocktailProvider>().fetchCocktails();
    });
  }

  void onSearchChanged(String value, List<Cocktail> cocktails) {
    setState(() {
      isSearching = value.trim().isNotEmpty;

      filteredCocktails = cocktails
          .where(
            (c) => c.name.toLowerCase().contains(value.toLowerCase()),
      )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = context.watch<FavoriteProvider>();
    final cocktailProvider = context.watch<CocktailProvider>();

    final cocktails = cocktailProvider.cocktails;
    final categories = cocktailProvider.categories;

    final baseUrl = 'http://10.0.2.2:8081';

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
      child: cocktailProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
        children: [
          CustomSearchBar(
            controller: searchController,
            hintText: 'Cerca un cocktail',
            icon: SvgPicture.asset(
              'assets/img/icone/search.svg',
              color: AppColors.fieldText,
            ),
            onChanged: (value) =>
                onSearchChanged(value, cocktails),
          ),

          const SizedBox(height: 16),

          if (isSearching)
            SearchResults(
              cocktails: filteredCocktails,
              favoriteProvider: favoriteProvider,
            ),

          if (isSearching && filteredCocktails.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Nessun cocktail trovato',
                style: TextStyle(color: Colors.grey),
              ),
            ),

          const SizedBox(height: 16),
          const Text(
            'Categorie',
            style: TextStyle(fontFamily: 'Gabarito', fontSize: 22),
          ),

          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];

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
                        builder: (_) => CategoryScreen(
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

          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: CustomButton(
              text: 'Crea il tuo cocktail',
              onPressed: () => widget.onChangePage(2),
            ),
          ),

          const Text(
            'Popolari',
            style: TextStyle(fontFamily: 'Gabarito', fontSize: 22),
          ),

          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cocktails.length,
              itemBuilder: (context, index) {
                final cocktail = cocktails[index];

                return CocktailCard(
                  imageUrl:
                  cocktail.imageUrl != null && cocktail.imageUrl!.isNotEmpty
                      ? baseUrl + cocktail.imageUrl!
                      : null,
                  image:
                  cocktail.imageUrl == null || cocktail.imageUrl!.isEmpty
                      ? Image.asset(
                    CocktailImages.getImage(cocktail.name),
                  )
                      : null,
                  color: CocktailColors.getColor(cocktail.name),
                  text: cocktail.name,
                  description: cocktail.description,
                  ingredients: cocktail.cocktailIngredients,
                  preparationMethod: cocktail.preparationMethod,
                  glassType: cocktail.glassType,
                  isFavorite:
                  favoriteProvider.isFavorite(cocktail.id),
                  cocktailId: cocktail.id,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
