import 'package:flutter/material.dart';
import 'package:flutter_cocktail/components/custom_app_bar.dart';
import 'package:flutter_cocktail/components/custom_button.dart';
import 'package:flutter_cocktail/screens/registration_screen.dart';

import '../theme/app_colors.dart';
import 'login_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              //card con coktail
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    width: 280,
                    height: 300,
                    decoration: BoxDecoration(
                      color: AppColors.tapBarBackground,
                      borderRadius: BorderRadius.circular(80),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  Image.asset("assets/img/generic/menu.png", height: 400),
                ],
              ),

              Spacer(),

              Text(
                "Prepara i tuoi cocktail con stile",
                style: TextStyle(fontFamily: 'Gabarito', fontSize: 32),
                textAlign: TextAlign.center,
              ),

              Spacer(),

              CustomButton(
                text: "Login",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrationScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "o crea un account",
                    style: TextStyle(
                      fontFamily: 'Gabarito',
                      fontSize: 20,
                      color: AppColors.buttonEnabled,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),

              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
