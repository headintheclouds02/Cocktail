import 'package:flutter/material.dart';
import '../model/ingredient_entry.dart';
import '../theme/app_colors.dart';

class ReminderList extends StatefulWidget {
  final ValueChanged<List<IngredientEntry>> onChanged;

  const ReminderList({super.key, required this.onChanged});

  @override
  _ReminderListState createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {
  final List<IngredientEntry> items = [IngredientEntry()];
  final List<String> units = ['ml', 'cl', 'g', 'pcs'];

  void _addItem() {
    setState(() {
      items.add(IngredientEntry());
    });
    widget.onChanged(items);
  }

  void _removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
    widget.onChanged(items);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ...List.generate(items.length, (index) {
            final item = items[index];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  // QTY
                  SizedBox(
                    width: 60,
                    child: TextField(
                      cursorColor: AppColors.tapBarBackground,
                      decoration: InputDecoration(
                        labelText: 'Qty',
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 8,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.tapBarBackground,
                          ),
                        ),
                        floatingLabelStyle: TextStyle(
                          color: AppColors.fieldText,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() => item.quantity = value);
                        widget.onChanged(items);
                      },
                    ),
                  ),

                  const SizedBox(width: 8),

                  // UNITÀ
                  SizedBox(
                    width: 110,
                    child: DropdownMenu<String>(
                      initialSelection: item.unit,
                      inputDecorationTheme: const InputDecorationTheme(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                      ),
                      dropdownMenuEntries: units.map((unit) {
                        return DropdownMenuEntry<String>(
                          value: unit,
                          label: unit,
                          style: ButtonStyle(
                            foregroundColor:
                            WidgetStateProperty.all(Colors.white),
                          ),
                        );
                      }).toList(),
                      onSelected: (value) {
                        if (value != null) {
                          setState(() => item.unit = value);
                          widget.onChanged(items);
                        }
                      },
                      textStyle: const TextStyle(color: Colors.black),
                      menuStyle: MenuStyle(
                        backgroundColor: WidgetStateProperty.all(
                          AppColors.tapBarBackground,
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // INGREDIENTE
                  Expanded(
                    child: TextField(
                      cursorColor: AppColors.tapBarBackground,
                      decoration: const InputDecoration(
                        labelText: 'Ingrediente',
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 8,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.tapBarBackground,
                          ),
                        ),
                        floatingLabelStyle: TextStyle(
                          color: AppColors.fieldText,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() => item.name = value);
                        widget.onChanged(items);
                      },
                    ),
                  ),

                  // 🗑️ CESTINO SEMPRE VISIBILE
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    color: Colors.redAccent,
                    tooltip: 'Rimuovi ingrediente',
                    onPressed: () => _removeItem(index),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
            label: const Text('Aggiungi riga'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.tapBarBackground,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
