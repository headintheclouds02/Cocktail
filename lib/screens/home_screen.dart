import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_svg/flutter_svg.dart';
import '../components/custom_button.dart';
import '../components/search_bar.dart';
import '../theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _State();
}

class _State extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Benvenuto!', style: TextStyle(fontFamily: 'Gabarito', fontSize: 32)),
          centerTitle: false,
        ),
        body: ListView(
          children: [
            CustomSearchBar(hintText: ('Cosa vuoi bere?'), onChanged: (value) {}, icon: SvgPicture.asset('assets/img/icone/search.svg', width: 20, height: 20, color: AppColors.iconFocused)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: CustomButton(text: 'Crea il tuo cocktail', onPressed: () {}),
            ),
            ],
        ),
      ),
    );
  }
}
