import 'package:flutter/material.dart';
import 'package:flutter_cocktail/components/custom_button.dart';
import 'package:flutter_cocktail/components/reminder_list.dart';
import 'package:flutter_cocktail/components/text_field.dart';
import 'package:flutter_svg/svg.dart';
import '../components/cocktail_image_picker.dart';
import '../components/search_bar.dart';
import '../theme/app_colors.dart';

class LiberaFantasiaScreen extends StatefulWidget {
  final String title;

  const LiberaFantasiaScreen({super.key, required this.title});

  @override
  State<LiberaFantasiaScreen> createState() => _LiberaFantasiaScreenState();
}

class _LiberaFantasiaScreenState extends State<LiberaFantasiaScreen> {
  final String title = 'Libera Fantasia';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(fontFamily: 'Gabarito', fontSize: 32),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                "Dai un nome al tuo cocktail",
                style: TextStyle(fontFamily: 'Gabarito', fontSize: 20),
              ),
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
              child: Text(
                "Scegli i tuoi ingredienti",
                style: TextStyle(fontFamily: 'Gabarito', fontSize: 20),
              ),
            ),

            ReminderList(),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                "Aggiungi una descrizione",
                style: TextStyle(fontFamily: 'Gabarito', fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: TextFieldCustom(
                maxLines: 5,
                minLines: 3,
                hintText: ('Scrivi una breve decrizione...'),
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
              child: Text(
                "Procedimento",
                style: TextStyle(fontFamily: 'Gabarito', fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: TextFieldCustom(
                maxLines: 5,
                minLines: 3,
                hintText: ('Come ottieni questo cocktail...'),
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
              child: Text(
                "Che tipo di bicchiere serve?",
                style: TextStyle(fontFamily: 'Gabarito', fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: TextFieldCustom(
                maxLines: 1,
                minLines: 1,
                hintText: ('Nome bicchiere...'),
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
              child: Text(
                "Immagini",
                style: TextStyle(fontFamily: 'Gabarito', fontSize: 20),
              ),
            ),

            CocktailImagePicker(),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: CustomButton(text: 'Salva Cocktail', onPressed: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
