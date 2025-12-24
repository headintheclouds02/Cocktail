import 'dart:async';
import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter/services.dart';
import 'package:flutter_cocktail/components/category_card.dart';
import 'package:flutter_cocktail/components/cocktail_card.dart';
import 'package:flutter_cocktail/utils/category_colors.dart';
import 'package:flutter_cocktail/utils/category_images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../components/custom_button.dart';
import '../components/search_bar.dart';
import '../model/cocktail.dart';
import '../model/favorite.dart';
import '../providers/favorite_provider.dart';
import '../service/token_storage.dart';
import '../theme/app_colors.dart';
import 'package:dio/dio.dart';
import '../utils/cocktail_colors.dart';
import '../utils/cocktail_images.dart';
import '../service/api_client.dart';
import '../service/auth_service.dart';

class HomeScreen extends StatefulWidget {
  final Function(int) onChangePage;

  const HomeScreen({super.key, required this.onChangePage});

  @override
  State<HomeScreen> createState() => _State();
}

class _State extends State<HomeScreen> {
  List<Cocktail> cocktails = [];

  late final TokenStorage _storage;
  late final AuthService _authService;
  late final ApiClient _apiClient;

  @override
  void initState() {
    super.initState();
    _storage = TokenStorage();
    _authService = AuthService(baseUrl: 'http://10.0.2.2:8081', storage: _storage);
    _apiClient = ApiClient(baseUrl: 'http://10.0.2.2:8081', authService: _authService, storage: _storage);
    fetchCocktails();
  }

  void fetchCocktails() async {
    try {
      final token = await _storage.getAccessToken();
      if (token == null || token.isEmpty) {
        await _storage.clear();

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sessione non valida, effettua il login.')),
        );

        Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
        return;
      }

      try {
        final response = await _apiClient.dio.get('/api/user/cocktails');

        final List<dynamic> data = response.data['content'];
        setState(() {
          cocktails = data.map((json) => Cocktail.fromJson(json)).toList();
        });
      } on DioError catch (e) {
        print('----->Error calling cocktails: ${e.response?.statusCode} ${e.message} ${e.response?.data}');
      } catch (e) {
        print('--------> Unexpected error calling cocktails: $e');
      }
    } on MissingPluginException catch (e) {
      print('MissingPluginException: assicurati di chiamare WidgetsFlutterBinding.ensureInitialized() in main.dart. $e');
    } catch (e) {
      print('Error getting token: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);


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
                  image: Image.asset(
                    CategoryImages.getImage(cocktails[index].category),
                  ),
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
