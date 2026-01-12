import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cocktail/components/custom_button.dart';
import 'package:flutter_cocktail/components/input_field_custom.dart';
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
    return nomeCocktail.trim().isEmpty || ingredienti.isEmpty;
  }

  Future<IngredientEntry?> _openIngredientDialog(BuildContext context) {
    String name = '';
    String amount = '';
    String unit = 'ml';

    final units = ['ml', 'g', 'pcs', 'cl'];

    return showDialog<IngredientEntry>(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nuovo ingrediente',
                    style: TextStyle(
                      fontFamily: 'Gabarito',
                      fontSize: 22,
                      color: Colors.black38,
                    ),
                  ),

                  const SizedBox(height: 24),

                  TextFieldCustom(
                    hintText: 'Ingrediente',
                    icon: SvgPicture.asset(
                      'assets/img/icone/search.svg',
                      color: AppColors.iconFocused,
                    ),
                    onChanged: (v) => name = v,
                    minLines: 1,
                    maxLines: 1,
                  ),

                  const SizedBox(height: 16),

                  TextFieldCustom(
                    hintText: 'Quantità (numero)',
                    icon: SvgPicture.asset(
                      'assets/img/icone/search.svg',
                      color: AppColors.iconFocused,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (v) => amount = v,
                    minLines: 1,
                    maxLines: 1,
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Unità di misura',
                    style: TextStyle(
                      fontFamily: 'Gabarito',
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 8,
                    children: units.map((u) {
                      final selected = unit == u;

                      return ChoiceChip(
                        selected: selected,
                        selectedColor: AppColors.tapBarBackground,
                        backgroundColor: Colors.white,
                        label: Text(
                          u,
                          style: TextStyle(
                            fontFamily: 'Gabarito',
                            color: selected
                                ? Colors.white
                                : AppColors.tapBarBackground,
                          ),
                        ),
                        onSelected: (_) {
                          unit = u;
                          (context as Element).markNeedsBuild();
                        },
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 32),

                  CustomButton(
                    text: 'Salva',
                    onPressed: () {
                      if (name.trim().isEmpty ||
                          amount.trim().isEmpty) {
                        return;
                      }

                      Navigator.pop(
                        context,
                        IngredientEntry(
                          name: name,
                          quantity: amount,
                          unit: unit,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  Widget _buildIngredientRow(IngredientEntry entry) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${entry.quantity} ${entry.unit} ${entry.name}',
              style: const TextStyle(fontSize: 18, fontFamily: 'Gabarito'),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              final removedIndex = ingredienti.indexOf(entry);
              final removedEntry = entry;

              setState(() {
                ingredienti.removeAt(removedIndex);
              });

              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      'Ingrediente rimosso',
                      style: const TextStyle(fontFamily: 'Gabarito'),
                    ),
                    action: SnackBarAction(
                      label: 'Annulla',
                      onPressed: () {
                        setState(() {
                          ingredienti.insert(removedIndex, removedEntry);
                        });
                      },
                    ),
                  ),
                );
            },
          ),

        ],
      ),
    );
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

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (ingredienti.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Text(
                        'Nessun ingrediente aggiunto',
                        style: TextStyle(color: Colors.grey),

                      ),
                    ),
                  ),

                ...ingredienti.map(_buildIngredientRow),

                const SizedBox(height: 12),

                Center(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Aggiungi ingrediente', style: TextStyle(fontFamily: 'Gabarito', fontSize: 18)),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.tapBarBackground,
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.transparent),

                    ),
                    onPressed: () async {
                      final newIngredient =
                      await _openIngredientDialog(context);

                      if (newIngredient != null) {
                        setState(() {
                          ingredienti.add(newIngredient);
                        });
                      }
                    },
                  ),
                ),
              ],
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
                style: TextStyle(fontFamily: 'Gabarito', fontSize: 22),
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
                        style: isSelected
                            ? TextStyle(
                                color: Colors.white,
                                fontFamily: 'Gabarito',
                                fontSize: 18,
                              )
                            : TextStyle(
                                color: AppColors.tapBarBackground,
                                fontFamily: 'Gabarito',
                                fontSize: 18,
                              ),
                      ),
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
                      const SnackBar(content: Text('Valori mancanti')),
                    );
                    return;
                  }

                  final saveProvider = context.read<SaveProvider>();

                  final model = CreateCocktail(
                    name: nomeCocktail,
                    description: descrizione,
                    cocktailIngredients: ingredienti
                        .map((e) => e.toCocktailIngredient())
                        .toList(),
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

                    await context.read<CocktailProvider>().fetchCocktails(
                      forceRefresh: true,
                    );

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


