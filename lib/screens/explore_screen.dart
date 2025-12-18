import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../components/cocktail_card.dart';
import '../model/cocktail.dart';
import '../theme/app_colors.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {

  List<Cocktail> cocktails = [];

  @override
  void initState() {
    super.initState();
    fetchCocktails();
  }

  void fetchCocktails() async {
    final dio = Dio();

    try {
      var response = await dio.get(
        'http://10.0.2.2:8081/api/public/cocktails',
      );
      print(response.statusCode);
      List<dynamic> data = response.data['content'];

      print(response);

      setState(() {
        cocktails = data.map((json) => Cocktail.fromJson(json)).toList();
      });
    } catch (e) {
      print("-----> $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: InkWell(
          onTap: () {
            // Azione al tap
          },
          child: GridView.count(
            crossAxisCount:2 ,
            childAspectRatio: 3/4,
            // Numero di colonne
            padding: EdgeInsets.all(10),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: List.generate(cocktails.length, (index) {
              return CocktailCard(
                image: Image.asset('assets/img/cocktail/margarita.png'),
                color: AppColors.margarita,
                text: cocktails[index].name,
                description: cocktails[index].description,
                ingredients: cocktails[index].cocktailIngredients,
              );
            }),
          ),
        ),
      ),
    );
  }
}
