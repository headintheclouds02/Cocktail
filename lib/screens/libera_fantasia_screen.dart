import 'package:flutter/material.dart';
import 'package:flutter_cocktail/components/text_field.dart';
import 'package:flutter_svg/svg.dart';

import '../components/search_bar.dart';
import '../theme/app_colors.dart';

class LiberaFantasiaScreen extends StatelessWidget {
  final String title;
  const LiberaFantasiaScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(fontFamily: 'Gabarito', fontSize: 32)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text("Dai un nome al tuo cocktail", style: TextStyle(fontFamily: 'Gabarito', fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: CustomSearchBar(
                hintText: ('Scegli il tuo nome'),
                onChanged: (value) {},
                icon: SvgPicture.asset(
                  'assets/img/icone/search.svg',
                  width: 20,
                  height: 20,
                  color: AppColors.iconFocused,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text("Scegli i tuoi ingredienti", style: TextStyle(fontFamily: 'Gabarito', fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: TextFieldCustom(
                hintText: ('Scegli il tuo nome'),
                onChanged: (value) {},
                icon: SvgPicture.asset(
                  'assets/img/icone/search.svg',
                  width: 20,
                  height: 20,
                  color: AppColors.iconFocused,
                ),
              ),
            ),
          ],

        ),
      ),

    );
  }
}
