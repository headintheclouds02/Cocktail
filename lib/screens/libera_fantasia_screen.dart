import 'package:flutter/material.dart';
import 'package:flutter_cocktail/components/custom_button.dart';
import 'package:flutter_cocktail/components/input_field_custom.dart';
import 'package:flutter_cocktail/components/reminder_list.dart';
import 'package:flutter_cocktail/components/text_field.dart';
import 'package:flutter_cocktail/model/ingredient.dart';
import 'package:flutter_svg/svg.dart';
import '../components/cocktail_image_picker.dart';
import '../model/ingredient_entry.dart';
import '../theme/app_colors.dart';
import 'package:provider/provider.dart';
import '../providers/save_provider.dart';


class LiberaFantasiaScreen extends StatefulWidget {
  final String title;

  const LiberaFantasiaScreen({super.key, required this.title});

  @override
  State<LiberaFantasiaScreen> createState() => _LiberaFantasiaScreenState();
}

class _LiberaFantasiaScreenState extends State<LiberaFantasiaScreen> {
  final String title = 'Libera la Fantasia';
  late String nomeCocktail = '';
  late String descrizione = '';
  late String categoria = '';
  late String procedimento = '';
  late String tipoBicchiere = '';
  late String immagine = '';
  late List<IngredientEntry> ingredienti = [];

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
              child: InputFieldCustom(
                hintText: ('Scegli il tuo nome'),
                onChanged: (value) {
                  nomeCocktail = value;
                },
                hideText: false,
                icon: null,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                "Scegli i tuoi ingredienti",
                style: TextStyle(fontFamily: 'Gabarito', fontSize: 20),
              ),
            ),

            ReminderList(
              onChanged: (updatedList) {
                setState(() {
                  ingredienti = updatedList;
                });
              },
            ),

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
                onChanged: (value) {
                  descrizione = value;
                },
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
                onChanged: (value) {
                  procedimento = value;
                },
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
                onChanged: (value) {
                  tipoBicchiere = value;
                },
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
              child: CustomButton(
                text: 'Salva Cocktail',
                onPressed: () async {
                  final payload = {
                    'name': nomeCocktail,
                    'description': descrizione,
                    'category': "Creato da me",
                    'glassType': tipoBicchiere,
                    'preparationMethod': procedimento,
                    'imageUrl' : "",
                    'alcoholic' : true,
                    'ingredients':  ingredienti.map((ing) => {
                      'name': ing.name,
                      'quantity': '${ing.quantity} ${ing.unit}',
                      'category': ing.category ?? '',
                      'description': ing.description ?? ''
                    }).toList(),
                  };

                  try {
                    await context.read<SaveProvider>().createCocktail(payload);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Cocktail creato con successo')),
                    );
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Errore nel salvataggio')),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
