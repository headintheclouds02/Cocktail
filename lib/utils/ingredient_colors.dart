import 'dart:ui';
import '../theme/app_colors.dart';

class IngredientColors {
  static const Map<String, Color> _colors = {
    'Menta': AppColors.menta,
    'Basilico': AppColors.basilico,

    'Sale': AppColors.sale,
    'Pepe': AppColors.pepe,

    'Succo di Lime': AppColors.succolime,
    'Succo di Limone': AppColors.succolimone,
    'Succo di Pomodoro': AppColors.succopomodoro,

    'Salsa Worcestershire': AppColors.worch,
    'Tabasco': AppColors.tabasco,

    'Prosecco' : AppColors.prosecco,

    'Limone' : AppColors.limone,
    'Arancia' : AppColors.arancia,
    'Lime' : AppColors.lime,

    'Soda' : AppColors.soda,
    'Acqua Tonica' : AppColors.soda,
    'Ginger Beer' : AppColors.gingerbeer,

    'Zucchero' : AppColors.zucchero,
    'Zucchero di Canna' : AppColors.zuccherocanna,
    'Sciroppo di Zucchero' : AppColors.sciroppozucchero,

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

