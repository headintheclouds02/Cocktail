import 'package:flutter/material.dart';
import 'package:flutter_cocktail/screens/main_page.dart';
import 'package:flutter_cocktail/screens/menu_screen.dart';
import 'package:flutter_cocktail/service/auth_service.dart';
import 'package:flutter_cocktail/service/token_storage.dart';
import 'package:flutter_cocktail/service/api_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  late final ApiClient _apiClient;

  @override
  void initState() {
    super.initState();
    _authService = AuthService(baseUrl: 'http://10.0.2.2:8081', storage: _storage);
    _apiClient = ApiClient(baseUrl: 'http://10.0.2.2:8081', authService: _authService, storage: _storage, onLogout: _onLogout);
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
    // schermo di avvio semplice
    return Scaffold(
      body: Center(child: Image.asset('assets/img/generic/splash.png')));
  }
}
