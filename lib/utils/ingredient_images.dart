class CategoryImages {
  static const String _basePath = 'assets/img/cocktail';
  static const String _basePath2 = 'assets/img/spiriti';


  static const Map<String, String> _images = {
    'Aperitivo': '$_basePath/spritz.png',
    'Vodka': '$_basePath2/vodka.png',
    'Gin': '$_basePath2/gin.png',
    'Rum': '$_basePath2/rumbianco.png',
    'Tequila': '$_basePath2/tequila.png',
  };

  static String getImage(String cocktailName) {
    return _images[cocktailName] ??
        '$_basePath/default.jpg';
  }
}
