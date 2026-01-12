import 'package:flutter/material.dart';
import 'package:flutter_cocktail/providers/auth_api_provider.dart';
import 'package:flutter_cocktail/providers/cocktail_provider.dart';
import 'package:flutter_cocktail/providers/save_provider.dart';
import 'package:flutter_cocktail/providers/theme_provider.dart';
import 'package:flutter_cocktail/screens/main_page.dart';
import 'package:flutter_cocktail/screens/menu_screen.dart';
import 'package:flutter_cocktail/service/api_client.dart';
import 'package:flutter_cocktail/service/auth_service.dart';
import 'package:flutter_cocktail/service/token_storage.dart';
import 'package:provider/provider.dart';
import 'providers/favorite_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final navigatorKey = GlobalKey<NavigatorState>();

  final tokenStorage = TokenStorage();
  final authService = AuthService(
    baseUrl: 'http://10.0.2.2:8081',
    storage: tokenStorage,
  );
  final apiClient = ApiClient(
    baseUrl: 'http://10.0.2.2:8081',
    authService: authService,
    storage: tokenStorage,
    onLogout: () {
      navigatorKey.currentState?.pushNamedAndRemoveUntil('/login', (r) => false);
    },
  );

  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: tokenStorage),
        Provider.value(value: authService),
        Provider.value(value: apiClient),

        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),

        ChangeNotifierProvider(
          create: (ctx) => FavoriteProvider(
            api: ctx.read<ApiClient>(),
            onShowMessage: (msg) {
              scaffoldMessengerKey.currentState?.showSnackBar(
                SnackBar(content: Text(msg)),
              );
            },
          ),
        ),

        ChangeNotifierProvider(
          create: (ctx) => AuthApiProvider(
            authService: ctx.read<AuthService>(),
          ),
        ),

        ChangeNotifierProvider(
          create: (ctx) => SaveProvider(
            api: ctx.read(),
          ),
        ),

        ChangeNotifierProvider(
          create: (ctx) => CocktailProvider(
            apiClient: ctx.read<ApiClient>(),
            storage: ctx.read<TokenStorage>(),
          ),
        ),


      ],
      child: MyApp(
        scaffoldMessengerKey: scaffoldMessengerKey,
        navigatorKey: navigatorKey,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({
    super.key,
    required this.scaffoldMessengerKey,
    required this.navigatorKey,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();


    return MaterialApp(
      title: 'Flutter Demo',
      scaffoldMessengerKey: scaffoldMessengerKey,
      navigatorKey: navigatorKey,
      home: const Startup(),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
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
  late TokenStorage _storage;
  late AuthService _authService;

  @override
  void initState() {
    super.initState();
    _storage = context.read<TokenStorage>();
    _authService = context.read<AuthService>();
    _checkLogin();
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

      // Provo il refresh token
      try {
        final newAuth = await _authService.refresh();
        await _storage.saveAccessToken(newAuth.accessToken);
        if (newAuth.refreshToken.isNotEmpty) {
          await _storage.saveRefreshToken(newAuth.refreshToken);
        }

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
      body: Center(
        child: Image.asset('assets/img/generic/splash.png'),
      ),
    );
  }
}
