import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_cocktail/components/category_card.dart';
import 'package:flutter_cocktail/components/cocktail_card.dart';
import 'package:flutter_cocktail/screens/add_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/custom_button.dart';
import '../components/search_bar.dart';
import '../model/cocktail.dart';
import '../theme/app_colors.dart';
import 'package:dio/dio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
    try {
      var response = await Dio().get(
        'http://localhost:8081/api/public/cocktails',
      );
      List<dynamic> data = response.data['content'];

      setState(() {
        cocktails = data.map((json) => Cocktail.fromJson(json)).toList();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Benvenuto!',
            style: TextStyle(fontFamily: 'Gabarito', fontSize: 32),
          ),
          centerTitle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      image: Image.asset('assets/img/spiriti/tequila.png'),
                      color: AppColors.tequila,
                      text: cocktails[index].name,
                    );
                  },
                ),
              ),

              //BUTTON CUSTOM
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                child: CustomButton(
                  text: 'Crea il tuo cocktail',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddScreen()),
                    );
                  },
                ),
              ),

              //TEXT "POPULAR"
              Text(
                "Popolari",
                style: TextStyle(fontFamily: 'Gabarito', fontSize: 22),
              ),

              //COCKTAIL CARD
              SizedBox(
                height: 250,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CocktailCard(
                      image: Image.asset('assets/img/cocktail/bloody.png'),
                      color: AppColors.bloody,
                      text: 'Bloody Mary',
                    ),

                    CocktailCard(
                      image: Image.asset('assets/img/cocktail/margarita.png'),
                      color: AppColors.margarita,
                      text: 'Margarita',
                    ),
                    CocktailCard(
                      image: Image.asset('assets/img/cocktail/mojito.png'),
                      color: AppColors.mojito,
                      text: 'Mojito',
                    ),
                    CocktailCard(
                      image: Image.asset('assets/img/cocktail/negroni.png'),
                      color: AppColors.negroni,
                      text: 'Negroni',
                    ),
                    CocktailCard(
                      image: Image.asset('assets/img/cocktail/spritz.png'),
                      color: AppColors.aperol,
                      text: 'Spritz',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
