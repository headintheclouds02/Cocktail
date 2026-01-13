class IngredientImages {
  static const String _bibitePath = 'assets/img/bibite';
  static const String _condPath = 'assets/img/condimenti';
  static const String _dolcPath = 'assets/img/dolcificanti';
  static const String _erbePath = 'assets/img/erbe';
  static const String _fruttaPath = 'assets/img/frutta';
  static const String _speziePath = 'assets/img/spezie';
  static const String _spiritiPath = 'assets/img/spiriti';
  static const String _succhiPath = 'assets/img/succhi';
  static const String _viniPath = 'assets/img/vini';



  static const Map<String, String> _images = {
    'Menta': '$_erbePath/menta.png',
    'Basilico': '$_erbePath/basilico.png',

    'Sale' : '$_speziePath/sale.png',
    'Pepe': '$_speziePath/pepe.png',

    'Succo di Lime': '$_succhiPath/succolime.png',
    'Succo di Limone': '$_succhiPath/succolimone.png',
    'Succo di Pomodoro': '$_succhiPath/succopomodoro.png',

    'Salsa Worcestershire': '$_condPath/worsterstershire.png',
    'Tabasco': '$_condPath/tabasco.png',

    'Prosecco': '$_viniPath/prosecco.png',

    'Lime': '$_fruttaPath/lime.png',
    'Limone': '$_fruttaPath/limone.png',
    'Arancia': '$_fruttaPath/arancia.png',

    'Soda': '$_bibitePath/tonica.png',
    'Acqua Tonica': '$_bibitePath/soda.png',
    'Ginger Beer': '$_bibitePath/ginger.png',

    'Zucchero': '$_dolcPath/zucchero.png',
    'Zucchero di Canna': '$_dolcPath/zuccherocanna.png',
    'Sciroppo di Zucchero': '$_dolcPath/sciroppozucchero.png',

    'Rum Bianco': '$_spiritiPath/rumbianco.png',
    'Rum Scuro': '$_spiritiPath/rumscuro.png',
    'Gin': '$_spiritiPath/gin.png',
    'Vodka': '$_spiritiPath/vodka.png',
    'Tequila': '$_spiritiPath/tequila.png',
    'Campari': '$_spiritiPath/campari.png',
    'Vermouth Rosso': '$_spiritiPath/vermouth.png',
    'Triple Sec': '$_spiritiPath/triplesec.png',
    'Aperol': '$_spiritiPath/aperol.png',

  };

  static String getImage(String ingredientName) {
    return _images[ingredientName] ??
        'assets/img/generic/placeholder.png';
  }
}
