import 'package:flutter/material.dart';
import 'package:flutter_cocktail/screens/main_page.dart';
import 'package:flutter_cocktail/screens/menu_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const FlutterSecureStorage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MenuScreen(),
      routes: {
        '/login': (context) => MenuScreen(),
      },
    );
  }
}

