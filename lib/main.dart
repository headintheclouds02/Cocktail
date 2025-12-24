import 'package:flutter/material.dart';
import 'package:flutter_cocktail/providers/auth_api_provider.dart';
import 'package:flutter_cocktail/screens/main_page.dart';
import 'package:flutter_cocktail/screens/menu_screen.dart';
import 'package:flutter_cocktail/service/auth_service.dart';
import 'package:flutter_cocktail/service/token_storage.dart';
import 'package:provider/provider.dart';
import 'providers/favorite_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FavoriteProvider(
            onShowMessage: (msg) {
              scaffoldMessengerKey.currentState?.showSnackBar(
                SnackBar(content: Text(msg)),
              );
            },
          ),
        ),
        ChangeNotifierProvider(create: (_) => AuthApiProvider()),
        // TODO: implements other providers here
      ],
      child: MyApp(scaffoldMessengerKey: scaffoldMessengerKey),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  const MyApp({super.key, required this.scaffoldMessengerKey});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: const Startup(),
      routes: {
        '/login': (context) => MenuScreen(),
        '/main': (context) => const MainPage(),
      },
    );
  }
}

class Startup extends StatefulWidget {
  const Startup({super.key});

  @override
  State<Startup> createState() => _StartupState();
}

class _StartupState extends State<Startup> {
  final TokenStorage _storage = TokenStorage();
  late final AuthService _authService;

  @override
  void initState() {
    super.initState();
    _authService = AuthService(
      baseUrl: 'http://10.0.2.2:8081',
      storage: _storage,
    );
    _checkLogin();
  }

  void _onLogout() {
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (r) => false);
  }

  Future<void> _checkLogin() async {
    try {
      if (await _storage.isAccessTokenValid()) {
        Navigator.of(context).pushReplacementNamed('/main');
        return;
      }

      final refresh = await _storage.getRefreshToken();
      if (refresh == null || refresh.isEmpty) {
        Navigator.of(context).pushReplacementNamed('/login');
        return;
      }

      // tenta refresh
      try {
        final newAuth = await _authService.refresh();
        await _storage.saveAccessToken(newAuth.accessToken);
        await _storage.saveRefreshToken(newAuth.refreshToken);
        Navigator.of(context).pushReplacementNamed('/main');
      } catch (_) {
        await _storage.clear();
        Navigator.of(context).pushReplacementNamed('/login');
      }
    } catch (_) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset('assets/img/generic/splash.png')),
    );
  }
}