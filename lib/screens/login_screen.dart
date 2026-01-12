import 'package:flutter/material.dart';
import 'package:flutter_cocktail/components/input_field_custom.dart';
import 'package:flutter_cocktail/screens/main_page.dart';
import 'package:flutter_cocktail/screens/registration_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../components/custom_app_bar.dart';
import '../components/custom_button.dart';
import '../providers/auth_api_provider.dart';
import '../theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordHidden = true;
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tapBarBackground,
      appBar: CustomAppBar(
        title: 'Bevo, quindi sono',
        image: 'assets/img/generic/logo_wht_nobg.png',
        enableBackPress: true,
      ),
      body: Stack(
        children: [
          //background image
          Positioned(
            bottom: 0,
            right: -55,
            child: Image.asset("assets/img/generic/login.png", height: 500),
          ),

          //foreground card
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(),
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
                        "Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: 'Gabarito', fontSize: 32),
                      ),
                      SizedBox(height: 24),

                      //nome
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Username",
                          style: TextStyle(fontFamily: 'Gabarito', fontSize: 20),
                        ),
                      ),

                      InputFieldCustom(
                        onChanged: (String value) {
                          _username = value.trim();
                        },
                        hintText: 'Inserisci username',
                        icon: SvgPicture.asset("assets/img/generic/user.svg"),
                        hideText: false,
                      ),

                      //cognome
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Password",
                          style: TextStyle(fontFamily: 'Gabarito', fontSize: 20),
                        ),
                      ),
                      InputFieldCustom(
                        onChanged: (String value) {
                          _password = value;
                        },
                        hintText: 'Inserisci password',
                        hideText: isPasswordHidden,
                        icon: SvgPicture.asset(
                          "assets/img/generic/password.svg",
                        ),
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
                      ),

                      SizedBox(height: 32),

                      CustomButton(
                        text: "Mixiamo!",
                        onPressed: () async {
                          if (_username.isEmpty || _password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Inserisci username e password')),
                            );
                            return;
                          }

                          final authProvider = context.read<AuthApiProvider>();

                          try {
                            await authProvider.login(_username, _password);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => MainPage()),
                                  (route) => false,
                            );
                          } catch (e) {
                            final msg = e.toString();
                            if (msg.contains('401')) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Credenziali non valide, riprova')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Login fallito')),
                              );
                            }
                          }
                        },
                      ),

                      SizedBox(height: 16),

                      Text(
                        'Prima volta al bancone?',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: 'Gabarito', fontSize: 20),
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
