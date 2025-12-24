import 'package:flutter/material.dart';
import 'package:flutter_cocktail/components/input_field_custom.dart';
import 'package:flutter_cocktail/screens/main_page.dart';
import 'package:flutter_cocktail/screens/registration_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/custom_app_bar.dart';
import '../components/custom_button.dart';
import '../theme/app_colors.dart';
import '../service/auth_service.dart';
import '../service/token_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordHidden = true;
  final _tokenStorage = TokenStorage();
  // baseUrl corretto: SOLO root del backend
  late final _authService = AuthService(baseUrl: 'http://10.0.2.2:8081', storage: _tokenStorage);

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
          Positioned(
            bottom: 0,
            right: -55,
            child: Image.asset("assets/img/generic/login.png", height: 500),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 80),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: AppColors.iconUnfocused.withOpacity(0.8),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Spacer(),
                      Text(
                        "Login",
                        style: TextStyle(fontFamily: 'Gabarito', fontSize: 32),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "Username",
                            style: TextStyle(
                              fontFamily: 'Gabarito',
                              fontSize: 20,
                            ),
                          ),
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "Password",
                            style: TextStyle(
                              fontFamily: 'Gabarito',
                              fontSize: 20,
                            ),
                          ),
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
                      Spacer(),
                      CustomButton(
                        text: "Mixiamo!",
                        onPressed: () async {
                          if (_username.isEmpty || _password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Inserisci username e password')),
                            );
                            return;
                          }

                          try {
                            await _authService.login(_username, _password);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => MainPage()),
                                  (route) => false,
                            );
                          } catch (e) {
                            final msg = e.toString();
                            if (msg.contains('401')) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Credenziali non valide (401)')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Login failed: $msg')),
                              );
                            }
                          }
                        },
                      ),
                      Spacer(),
                      Text(
                        'Prima volta al bancone?',
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            "Unisciti a noi",
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
