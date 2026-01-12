import 'package:flutter/material.dart';
import 'package:flutter_cocktail/screens/home_screen.dart';
import 'package:flutter_cocktail/screens/explore_screen.dart';
import 'package:flutter_cocktail/screens/add_screen.dart';
import 'package:flutter_cocktail/screens/favorite_screen.dart';
import 'package:flutter_cocktail/screens/profile_screen.dart';
import 'package:provider/provider.dart';
import '../components/custom_tapbar.dart';
import '../providers/theme_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  //GESTISCE IL CICLO DI VITA DEI DATI
  //non viene chiamato da te manualmente
  //
  // viene chiamato automaticamente dal framework Flutter quando il widget viene rimosso definitivamente dall’albero dei widget
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  //lista di widget per le pagine
  late final List<Widget> _pages = [
    //ho dovuto aggiungere questi parametri a homescreen per far si chè da homescreen, con la pressione di un
    // custombutton, si possa navigare a una delle schermatre della pageview
    HomeScreen(
      onChangePage: (index) {
        _pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      },
    ),
    const ExploreScreen(),
    const AddScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];

  //lista di titoli da abbiare alla pagina per l'appbar
  final List<String> _titles = [
    "Benvenuto!",
    "Esplora",
    "Sperimenta",
    "Cocktail preferiti",
    "Profilo",
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();


    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_currentIndex],
          style: TextStyle(fontFamily: 'Gabarito', fontSize: 32),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(
              context.watch<ThemeProvider>().isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              context.read<ThemeProvider>().toggleTheme();
            },
          )
        ],
      ),
      body: PageView(
        controller: _pageController,
        // serve a disabilitare lo swipe manuale tra le schermate
        //physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: CustomTapbar(
        currentIndex: _currentIndex,
        onTap: (index) {
          //.jumpToPage naviga tra schermate senza animazioni
          //_pageController.jumpToPage(index);

          //.animateToPage() naviga tra schermate con animazioni
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 600),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}
