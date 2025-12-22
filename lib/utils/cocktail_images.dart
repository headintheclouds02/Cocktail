class CocktailImages {
  static const String _basePath = 'assets/img/cocktail';

  static const Map<String, String> _images = {
    'Mojito': '$_basePath/mojito.png',
    'Negroni': '$_basePath/negroni.png',
    'Aperol Spritz': '$_basePath/spritz.png',
    'Margarita': '$_basePath/margarita.png',
    'Bloody Mary': '$_basePath/bloody.png',
  };

  static String getImage(String cocktailName) {
    return _images[cocktailName] ??
        '$_basePath/default.jpg';
  }
}
