import 'package:flutter/material.dart';
import 'package:flutter_cocktail/screens/registration_screen.dart';

import '../components/custom_button.dart';
import '../theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    //return Scaffold(
    //  backgroundColor: AppColors.tapBarBackground,
    //
    //  appBar: AppBar(
    //    title: Row(
    //      mainAxisAlignment: MainAxisAlignment.center,
    //      children: [
    //        Padding(
    //          padding: const EdgeInsets.symmetric(horizontal: 4),
    //          child: SizedBox(
    //            width: 45,
    //            height: 45,
    //            child: Image.asset("assets/img/generic/logo_wht_nobg.png"),
    //          ),
    //        ),
    //        Padding(
    //          padding: const EdgeInsets.symmetric(horizontal: 4),
    //          child: Text(
    //            "Bevo, quindi sono",
    //            style: TextStyle(fontFamily: 'Gabarito', fontSize: 22),
    //          ),
    //        ),
    //      ],
    //    ),
    //    backgroundColor: AppColors.tapBarBackground,
    //    //leading: IconButton(
    //    //  onPressed: () {Navigator.pop(context);},
    //    //  icon: Icon(Icons.arrow_back, color: AppColors.iconUnfocused),
    //    //),
    //  ),
    //  body: Column(
    //    children: [
    //      Positioned(
    //        child: Image.asset("assets/img/generic/login.png", height: 400),
    //        bottom: 0,
    //        right: -30,
    //      ),
    //      Padding(
    //        padding: const EdgeInsets.symmetric(horizontal: 32),
    //        child: Stack(
    //          children: [
//
//
//
//
    //            Container(
    //              width: double.infinity,
//
    //              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//
    //              decoration: BoxDecoration(
    //                borderRadius: BorderRadius.circular(25),
    //                color: AppColors.iconUnfocused.withOpacity(0.8),
    //              ),
    //              child: Column(
    //                children: [
    //                  Text(
    //                    "Login",
    //                    style: TextStyle(fontFamily: 'Gabarito', fontSize: 32),
    //                  ),
//
    //                  Text(
    //                    "Email",
    //                    style: TextStyle(fontFamily: 'Gabarito', fontSize: 20),
    //                  ),
    //                ],
    //              ),
    //            ),
//
    //            Spacer(),
//
    //            CustomButton(
    //              text: "Login",
    //              onPressed: () {
    //                Navigator.push(
    //                  context,
    //                  MaterialPageRoute(builder: (context) => LoginScreen()),
    //                );
    //              },
    //            ),
//
    //            TextButton(
    //              onPressed: () {
    //                Navigator.push(
    //                  context,
    //                  MaterialPageRoute(builder: (context) => RegistrationScreen()),
    //                );
    //              },
    //              child: Padding(
    //                padding: const EdgeInsets.all(16.0),
    //                child: Text(
    //                  "o crea un account",
    //                  style: TextStyle(
    //                    fontFamily: 'Gabarito',
    //                    fontSize: 20,
    //                    color: AppColors.buttonEnabled,
    //                    decoration: TextDecoration.underline,
    //                  ),
    //                ),
    //              ),
    //            ),
//
    //            Spacer(),
    //          ],
    //        ),
    //      ),
    //    ]
//
//
    //  )
//
    //);

    return Scaffold(
      backgroundColor: AppColors.tapBarBackground,

        appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: SizedBox(
                      width: 45,
                      height: 45,
                      child: Image.asset("assets/img/generic/logo_wht_nobg.png"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      "Bevo, quindi sono",
                      style: TextStyle(fontFamily: 'Gabarito', fontSize: 22),
                    ),
                  ),
                ],
              ),
              backgroundColor: AppColors.tapBarBackground,
              //leading: IconButton(
              //  onPressed: () {Navigator.pop(context);},
              //  icon: Icon(Icons.arrow_back, color: AppColors.iconUnfocused),
              //),
            ),

    );
  }
}
