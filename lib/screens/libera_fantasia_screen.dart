import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cocktail/components/custom_button.dart';
import 'package:flutter_cocktail/components/input_field_custom.dart';
import 'package:flutter_cocktail/components/reminder_list.dart';
import 'package:flutter_cocktail/components/text_field.dart';
import 'package:flutter_svg/svg.dart';
import '../components/cocktail_image_picker.dart';
import '../model/create_cocktail.dart';
import '../model/ingredient_entry.dart';
import '../providers/cocktail_provider.dart';
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
  String nomeCocktail = '';
  String descrizione = '';
  String procedimento = '';
  String tipoBicchiere = '';
  List<IngredientEntry> ingredienti = [];
  File? selectedImageFile;

  String selectedCategory = 'Altro';

  bool _hasMissingFields() {
    return nomeCocktail.trim().isEmpty ||
        ingredienti.isEmpty;
  }



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
              padding: const EdgeInsets.only(top: 32),
              child: Text(
                "Dai un nome al tuo cocktail",
                style: TextStyle(fontFamily: 'Gabarito', fontSize: 25),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
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
              padding: const EdgeInsets.only(top: 48),
              child: Text(
                "Scegli i tuoi ingredienti",
                style: TextStyle(fontFamily: 'Gabarito', fontSize: 25),
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
              padding: const EdgeInsets.only(top: 48),
              child: Text(
                "Aggiungi una descrizione",
                style: TextStyle(fontFamily: 'Gabarito', fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
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
              padding: const EdgeInsets.only(top: 48),
              child: Text(
                "Procedimento",
                style: TextStyle(fontFamily: 'Gabarito', fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
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
              padding: const EdgeInsets.only(top: 32),
              child: Text(
                'Categoria',
                style: TextStyle(
                  fontFamily: 'Gabarito',
                  fontSize: 22,
                ),
              ),
            ),

            Consumer<CocktailProvider>(
              builder: (context, provider, _) {
                final categories = provider.categories;

                if (categories.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Nessuna categoria disponibile'),
                  );
                }

                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: categories.map((category) {
                    final isSelected = selectedCategory == category;

                    return ChoiceChip(
                      selectedColor: AppColors.tapBarBackground,
                      label: Text(
                          category,
                          style: isSelected ? TextStyle(color: Colors.white, fontFamily: 'Gabarito', fontSize: 18) : TextStyle(color: AppColors.tapBarBackground, fontFamily: 'Gabarito', fontSize: 18)),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                    );
                  }).toList(),
                );
              },
            ),


            Padding(
              padding: const EdgeInsets.only(top: 48),
              child: Text(
                "Che tipo di bicchiere serve?",
                style: TextStyle(fontFamily: 'Gabarito', fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
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
              padding: const EdgeInsets.only(top: 48),
              child: Text(
                "Immagine",
                style: TextStyle(fontFamily: 'Gabarito', fontSize: 25),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: CocktailImagePicker(
                onImageSelected: (File? file) {
                  setState(() {
                    selectedImageFile = file;
                  });
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: CustomButton(
                text: 'Salva Cocktail',
                onPressed: () async {
                  if (_hasMissingFields()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Valori mancanti'),
                      ),
                    );
                    return;
                  }

                  final saveProvider = context.read<SaveProvider>();

                  final model = CreateCocktail(
                    name: nomeCocktail,
                    description: descrizione,
                    cocktailIngredients:
                    ingredienti.map((e) => e.toCocktailIngredient()).toList(),
                    category: selectedCategory,
                    glassType: tipoBicchiere,
                    preparationMethod: procedimento,
                    alcoholic: true,
                  );

                  try {
                    await saveProvider.saveCocktail(
                      model,
                      imageFile: selectedImageFile,
                    );

                    if (!mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cocktail salvato con successo'),
                      ),
                    );

                    await context
                        .read<CocktailProvider>()
                        .fetchCocktails(forceRefresh: true);

                    Navigator.of(context).pop();

                  } catch (e, stackTrace) {
                    debugPrint('Errore creazione cocktail: $e');
                    debugPrintStack(stackTrace: stackTrace);

                    if (!mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Impossibile creare il cocktail'),
                      ),
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
