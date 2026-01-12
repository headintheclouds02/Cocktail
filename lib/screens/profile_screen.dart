import 'package:flutter/material.dart';
import 'package:flutter_cocktail/components/cocktail_card.dart';
import 'package:flutter_cocktail/components/custom_button.dart';
import 'package:provider/provider.dart';
import '../model/cocktail.dart';
import '../providers/auth_api_provider.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

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

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: CustomButton(
              text: 'Logout',
              onPressed: () async {
                final authProvider =
                Provider.of<AuthApiProvider>(context, listen: false);
                final favoriteProvider =
                Provider.of<FavoriteProvider>(context, listen: false);
                final cocktailProvider =
                Provider.of<CocktailProvider>(context, listen: false);

                // 1. Logout reale
                await authProvider.logout();

                // 2. Reset stato locale
                favoriteProvider.clear();
                cocktailProvider.clear();

                // 3. Navigazione pulita
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const MenuScreen()),
                      (_) => false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
