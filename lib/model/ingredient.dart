class Ingredient {
  final int id;
  final String name;
  final String category;
  final String unit;
  final String? description;

  Ingredient({
    required this.id,
    required this.name,
    required this.category,
    required this.unit,
    this.description,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      unit: json['unit'] ?? '',
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'unit': unit,
      'description': description,
    };
  }
}
