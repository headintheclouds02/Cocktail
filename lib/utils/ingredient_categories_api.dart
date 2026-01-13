import 'package:dio/dio.dart';

class IngredientCategoriesApi {
  static Future<List<String>> fetch() async {
    final dio = Dio();
    final response = await dio.get(
      'http://10.0.2.2:8081/api/ingredients/grouped-by-category',
    );

    final Map<String, dynamic> data = response.data;
    return data.keys.toList();
  }
}
