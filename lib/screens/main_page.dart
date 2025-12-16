import 'package:flutter/material.dart';
import 'package:flutter_cocktail/screens/home_screen.dart';
import 'package:flutter_cocktail/screens/explore_screen.dart';
import 'package:flutter_cocktail/screens/add_screen.dart';
import 'package:flutter_cocktail/screens/cart_screen.dart';
import 'package:flutter_cocktail/screens/profile_screen.dart';
import '../components/custom_tapbar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  Widget _getPage(int index) {
    switch (index) {
      case 0: return HomeScreen();
      case 1: return ExploreScreen();
      case 2: return AddScreen();
      case 3: return CartScreen();
      case 4: return ProfileScreen();
      default: return HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(_currentIndex),
      bottomNavigationBar: CustomTapbar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}