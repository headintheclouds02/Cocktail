import 'package:flutter/material.dart';
import '../model/ingredient_entry.dart';

class ReminderList extends StatefulWidget {
  const ReminderList({super.key});

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
                  SizedBox(
                    width: 60,
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Qty',
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          item.quantity = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  DropdownButton<String>(
                    value: item.unit,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          item.unit = value;
                        });
                      }
                    },
                    items: units
                        .map((unit) => DropdownMenuItem(
                      value: unit,
                      child: Text(unit),
                    ))
                        .toList(),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Ingrediente',
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      ),
                      onChanged: (value) {
                        setState(() {
                          item.name = value;
                        });
                      },
                    ),
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
            style: ButtonStyle(),
          ),
        ],
      ),
    );
  }
}
