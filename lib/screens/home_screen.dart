import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_cocktail/components/category_card.dart';
import 'package:flutter_cocktail/components/cocktail_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/custom_button.dart';
import '../components/search_bar.dart';
import '../theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _State();
}

class _State extends State<HomeScreen> {

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

              SizedBox(
                height: 160,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                    children: [
                    CategoryCard(
                      image: Image.asset('assets/img/cocktail/spritz.png'),
                      color: AppColors.aperol,
                      text: 'Aperitivo',
                    ),

                    CategoryCard(
                      image: Image.asset('assets/img/spiriti/vodka.png'),
                      color: AppColors.vodka,
                      text: 'Vodka',
                    ),
                    CategoryCard(
                      image: Image.asset('assets/img/vini/prosecco.png'),
                      color: AppColors.prosecco,
                      text: 'Prosecco',
                    ),
                    CategoryCard(
                      image: Image.asset('assets/img/spiriti/tequila.png'),
                      color: AppColors.tequila,
                      text: 'Tequila',
                    ),
                    CategoryCard(
                      image: Image.asset('assets/img/spiriti/rumbianco.png'),
                      color: AppColors.aperol,
                      text: 'Rum',
                    ),
                  ],
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
                  onPressed: () {},
                ),
              ),

              //TEXT "POPULAR"
              Text(
                "Popolari",
                style: TextStyle(fontFamily: 'Gabarito', fontSize: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
