import 'dart:ui';
import '../theme/app_colors.dart';

class IngredientColors {
  static const Map<String, Color> _colors = {
    'Menta': AppColors.aperol,
    'Basilico': AppColors.vodka,

    'Sale': AppColors.gin,
    'Pepe': AppColors.rumB,

    'Succo di Lime': AppColors.rumB,
    'SUcco di Limone': AppColors.rumB,
    'Succo di Pomodoro': AppColors.rumB,

    'Salsa Worcestershire': AppColors.rumB,
    'Tabasco': AppColors.rumB,

    'Prosecco' : AppColors.rumB,

    'Limone' : AppColors.rumB,
    'Arancia' : AppColors.rumB,
    'Lime' : AppColors.rumB,

    'Soda' : AppColors.rumB,
    'Acqua Tonica' : AppColors.rumB,
    'Ginger Beer' : AppColors.rumB,

    'Zucchero' : AppColors.rumB,
    'Zucchero di Canna' : AppColors.rumB,
    'Sciroppo di Zucchero' : AppColors.rumB,

    'Rum Bianco' : AppColors.rumB,
    'Rum Scuro' : AppColors.rumS,
    'Gin' : AppColors.gin,
    'Vodka' : AppColors.vodka,
    'Tequila' : AppColors.tequila,
    'Campari' : AppColors.campari,
    'Vermouth Rosso' : AppColors.vermouth,
    'Triple Sec' : AppColors.triple,
    'Aperol' : AppColors.aperol,
  };

  static Color getColor(String ingredientName) {
    return _colors[ingredientName] ?? AppColors.background;
  }
}

