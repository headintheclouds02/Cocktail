import 'package:flutter/material.dart';
import 'package:flutter_cocktail/components/custom_app_bar.dart';
import 'package:flutter_cocktail/screens/login_screen.dart';
import 'package:flutter_svg/svg.dart';
import '../components/custom_button.dart';
import '../components/input_field_custom.dart';
import '../theme/app_colors.dart';
import 'main_page.dart';
import '../service/auth_service.dart';
import '../service/token_storage.dart';
import 'package:flutter/widgets.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isPasswordHidden = true;
  bool isPasswordHidden1 = true;

  final _tokenStorage = TokenStorage();
  late final _authService = AuthService(baseUrl: 'http://10.0.2.2:8081/api/auth/register', storage: _tokenStorage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.registrationBg,
      appBar: CustomAppBar(
        enableBackPress: true,
        title: 'Bevo, quindi sono',
        image: "assets/img/generic/logo_pnk_nobg.png",
      ),
      body: Stack(
        children: [
          // Background
          Positioned(
            bottom: 0,
            right: -55,
            child: Image.asset(
              "assets/img/generic/registrazione.png",
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

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Nome",
                        style: TextStyle(
                          fontFamily: 'Gabarito',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    InputFieldCustom(
                      hintText: 'Inserisci nome',
                      icon: SvgPicture.asset("assets/img/generic/user.svg"),
                      hideText: false,
                      onChanged: (_) {},
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Cognome",
                        style: TextStyle(
                          fontFamily: 'Gabarito',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    InputFieldCustom(
                      hintText: 'Inserisci cognome',
                      icon: SvgPicture.asset("assets/img/generic/user.svg"),
                      hideText: false,
                      onChanged: (_) {},
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Username",
                        style: TextStyle(
                          fontFamily: 'Gabarito',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    InputFieldCustom(
                      hintText: 'Inserisci username',
                      icon: SvgPicture.asset("assets/img/generic/user.svg"),
                      hideText: false,
                      onChanged: (_) {},
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Email",
                        style: TextStyle(
                          fontFamily: 'Gabarito',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    InputFieldCustom(
                      hintText: 'Inserisci email',
                      icon: SvgPicture.asset("assets/img/generic/mail.svg"),
                      hideText: false,
                      onChanged: (_) {},
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Password",
                        style: TextStyle(
                          fontFamily: 'Gabarito',
                          fontSize: 20,
                        ),
                      ),
                    ),
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
                      onChanged: (String value) {},
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Ripeti password",
                        style: TextStyle(
                          fontFamily: 'Gabarito',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    InputFieldCustom(
                      hintText: 'Inserisci password',
                      hideText: isPasswordHidden,
                      icon: SvgPicture.asset("assets/img/generic/password.svg"),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordHidden1 = !isPasswordHidden1;
                          });
                        },
                        icon: SvgPicture.asset(
                          isPasswordHidden1
                              ? "assets/img/generic/hide.svg"
                              : "assets/img/generic/show.svg",
                        ),
                      ),
                      onChanged: (String value) {},
                    ),

                    const SizedBox(height: 32),

                    CustomButton(
                      text: "Iniziamo!",
                      onPressed: () {
                        onPressed: () async {
                          final payload = {
                            'username': 'nuovoUtente',
                            'password': 'pass',
                            // altri campi richiesti dal backend
                          };

                          try {
                            await _authService.register(payload);
                            // opzionale: auto-login dopo registrazione
                            final auth = await _authService.login(payload['username']!, payload['password']!);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => MainPage()),
                                  (route) => false,
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Registrazione fallita: ${e.toString()}')),
                            );
                          }
                        };
                      },
                    ),

                    const SizedBox(height: 16),

                    Text(
                      'Fai già parte del nostro club?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'Gabarito', fontSize: 18),
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Accedi al lounge",
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

