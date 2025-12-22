import 'dart:ui';
import '../theme/app_colors.dart';

class CocktailColors {

  static const Map<String, Color> _colors = {
    'Mojito': AppColors.mojito,
    'Negroni': AppColors.negroni,
    'Aperol Spritz': AppColors.aperol,
    'Margarita': AppColors.margarita,
    'Bloody Mary': AppColors.bloody,
  };

  static Color getColor(String cocktailName) {
    return _colors[cocktailName] ??
        AppColors.background;
  }
}
