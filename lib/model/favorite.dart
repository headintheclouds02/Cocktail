import 'cocktail.dart';

class Favorite {
  final int id;
  final String userId;
  final Cocktail cocktail;

  Favorite({
    required this.id,
    required this.userId,
    required this.cocktail,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['id'],
      userId: json['userId'],
      cocktail: Cocktail.fromJson(json['cocktail']),
    );
  }
}
