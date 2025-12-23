import 'cocktail.dart';
import 'favorite_color.dart';

class Favorite {
  final int id;
  final String userId;
  final Cocktail cocktail;
  final FavoriteColor color;

  Favorite({
    required this.id,
    required this.userId,
    required this.cocktail,
    required this.color,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['id'],
      userId: json['userId'],
      cocktail: Cocktail.fromJson(json['cocktail']),
      color: FavoriteColor.fromJson(json['color']),
    );
  }
}
