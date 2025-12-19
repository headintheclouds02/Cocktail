import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../components/custom_button.dart';
import '../components/input_field_custom.dart';
import '../theme/app_colors.dart';
import 'main_page.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.registrationBg,

      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: SizedBox(
                width: 45,
                height: 45,
                child: Image.asset("assets/img/generic/logo_pnk_nobg.png"),
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
        backgroundColor: AppColors.registrationBg,
      ),

      body: Stack(
        children: [
          // Background
          Positioned(
            bottom: 0,
            right: -55,
            child: Image.asset(
              "assets/img/generic/login.png",
              height: 500,
            ),
          ),

          // Foreground card
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(
                  maxWidth: 420, // opzionale, migliora UI su tablet
                ),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.iconUnfocused.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Registrati",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Gabarito',
                        fontSize: 32,
                      ),
                    ),
                    const SizedBox(height: 24),

                    _label("Nome"),
                    InputFieldCustom(
                      hintText: 'Inserisci nome',
                      icon: SvgPicture.asset("assets/img/generic/user.svg"),
                      hideText: false,
                      onChanged: (_) {},
                    ),

                    _label("Cognome"),
                    InputFieldCustom(
                      hintText: 'Inserisci cognome',
                      icon: SvgPicture.asset("assets/img/generic/user.svg"),
                      hideText: false,
                      onChanged: (_) {},
                    ),

                    _label("Username"),
                    InputFieldCustom(
                      hintText: 'Inserisci username',
                      icon: SvgPicture.asset("assets/img/generic/user.svg"),
                      hideText: false,
                      onChanged: (_) {},
                    ),

                    _label("Email"),
                    InputFieldCustom(
                      hintText: 'Inserisci email',
                      icon: SvgPicture.asset("assets/img/generic/mail.svg"),
                      hideText: false,
                      onChanged: (_) {},
                    ),

                    _label("Password"),
                    InputFieldCustom(
                      hintText: 'Inserisci password',
                      hideText: isPasswordHidden,
                      icon: SvgPicture.asset("assets/img/generic/password.svg"),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordHidden = !isPasswordHidden;
                          });
                        },
                        icon: SvgPicture.asset(
                          isPasswordHidden
                              ? "assets/img/generic/hide.svg"
                              : "assets/img/generic/show.svg",
                        ),
                      ),
                      onChanged: (_) {},
                    ),

                    _label("Ripeti Password"),
                    InputFieldCustom(
                      hintText: 'Inserisci password',
                      hideText: isPasswordHidden,
                      icon: SvgPicture.asset("assets/img/generic/password.svg"),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordHidden = !isPasswordHidden;
                          });
                        },
                        icon: SvgPicture.asset(
                          isPasswordHidden
                              ? "assets/img/generic/hide.svg"
                              : "assets/img/generic/show.svg",
                        ),
                      ),
                      onChanged: (_) {},
                    ),

                    const SizedBox(height: 32),

                    CustomButton(
                      text: "Mixiamo!",
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => MainPage()),
                              (_) => false,
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    Text(
                      'Prima volta al bancone?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'Gabarito', fontSize: 18),
                    ),

                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Unisciti a noi",
                        style: TextStyle(
                          fontFamily: 'Gabarito',
                          fontSize: 18,
                          color: AppColors.buttonEnabled,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}

Widget _label(String text) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 8),
  child: Text(
    text,
    style: TextStyle(
      fontFamily: 'Gabarito',
      fontSize: 20,
    ),
  ),
);

