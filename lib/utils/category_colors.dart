import 'dart:ui';
import '../theme/app_colors.dart';

class CategoryColors {
  static const Map<String, Color> _colors = {
    'Aperitivo': AppColors.aperol,
    'Vodka': AppColors.vodka,
    'Gin': AppColors.gin,
    'Rum': AppColors.rumB,
    'Tequila': AppColors.tequila,
  };

  static Color getColor(String cocktailName) {
    return _colors[cocktailName] ?? AppColors.background;
  }
}
