import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import '../components/cocktail_card.dart';
import '../model/cocktail.dart';
import '../model/favorite.dart';
import '../service/api_client.dart';
import '../service/auth_service.dart';
import '../service/token_storage.dart';
import '../utils/cocktail_colors.dart';
import '../utils/cocktail_images.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Favorite> favorites = [];

  late final TokenStorage _storage;
  late final AuthService _authService;
  late final ApiClient _apiClient;

  @override
  void initState() {
    super.initState();
    _storage = TokenStorage();
    _authService = AuthService(baseUrl: 'http://10.0.2.2:8081', storage: _storage);
    _apiClient = ApiClient(baseUrl: 'http://10.0.2.2:8081', authService: _authService, storage: _storage);

    fetchFavorites();
  }

  void fetchFavorites() async {
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
        final response = await _apiClient.dio.get('/api/favorites');
        print('STATUS: ${response.statusCode}');
        print('DATA: ${response.data}');


        final List<dynamic> data = response.data;
        setState(() {
          favorites = data.map((json) => Favorite.fromJson(json)).toList();
        });
      } on DioError catch (e) {
        print('Errore chiamata favorites: ${e.response?.statusCode} ${e.message} ${e.response?.data}');
      } catch (e) {
        print('Errore inatteso chiamata favorites: $e');
      }
    } on MissingPluginException catch (e) {
      print('MissingPluginException: assicurati di chiamare WidgetsFlutterBinding.ensureInitialized() in main.dart. $e');
    } catch (e) {
      print('Errore recupero token: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 3 / 4,
      // Numero di colonne
      padding: EdgeInsets.all(10),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children:

      List.generate(favorites.length, (index) {
        final favorite = favorites[index];

        return CocktailCard(
          image: Image.asset(
            CocktailImages.getImage(favorite.cocktail.name),
          ),
          color: favorite.color.toColor(),
          text: favorite.cocktail.name,
          description: favorite.cocktail.description,
          ingredients: favorite.cocktail.cocktailIngredients,
          preparationMethod: favorite.cocktail.preparationMethod,
          glassType: favorite.cocktail.glassType,

        );
      }),

    );
  }
}
