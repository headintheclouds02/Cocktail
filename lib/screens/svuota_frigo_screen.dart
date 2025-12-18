import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../components/category_card.dart';
import '../model/cocktail.dart';
import '../theme/app_colors.dart';

class SvuotaFrigoScreen extends StatefulWidget {
  final String title;
  const SvuotaFrigoScreen({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SvuotaFrigoScreen> {
  List<Cocktail> cocktails = [];

  @override
  void initState() {
    super.initState();
    fetchIngredients();
  }

  void fetchIngredients() async {
    final dio = Dio();

    try {
      var response = await dio.get('http://10.0.2.2:8081/api/public/cocktails');
      //print(response.statusCode);
      List<dynamic> data = response.data['content'];

      print(response);

      setState(() {
        cocktails = data.map((json) => Cocktail.fromJson(json)).toList();
        print(cocktails);
      });
    } catch (e) {
      print("-----> $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontFamily: 'Gabarito', fontSize: 32),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            Text("Quale ingrediente domina il tuo frigo?", style: TextStyle(fontFamily: 'Gabarito', fontSize: 18)),
          ],
        ),
      ),

    );
  }
}
