import 'package:flutter/material.dart';
import 'package:flutter_cocktail/components/cocktail_card.dart';
import 'package:flutter_cocktail/components/custom_button.dart';
import 'package:provider/provider.dart';
import '../model/cocktail.dart';
import '../providers/auth_api_provider.dart';
import '../providers/cocktail_provider.dart';
import '../providers/favorite_provider.dart';
import '../utils/cocktail_colors.dart';
import '../utils/cocktail_images.dart';
import 'menu_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final avatars = [
    'assets/img/avatar/1.png',
    'assets/img/avatar/2.png',
    'assets/img/avatar/3.png',
    'assets/img/avatar/4.png',
    'assets/img/avatar/5.png',
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<AuthApiProvider>().loadAvatar();
    });
  }

  void _openAvatarPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        final authProvider = context.read<AuthApiProvider>();

        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Scegli il tuo avatar',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              GridView.builder(
                shrinkWrap: true,
                itemCount: avatars.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (_, index) {
                  final path = avatars[index];

                  return GestureDetector(
                    onTap: () {
                      authProvider.setAvatar(path);
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(path),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthApiProvider>();
    final auth = authProvider.auth;
    const avatarSize = 120.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              auth?.firstName != null
                  ? "Benvenuto nella tua area personale ${auth!.firstName}!"
                  : "Benvenuto nella tua area personale",
              style: TextStyle(fontFamily: 'Gabarito', fontSize: 26),
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: avatarSize,
                height: avatarSize,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: avatarSize / 2,
                      backgroundImage: authProvider.avatarPath != null
                          ? AssetImage(authProvider.avatarPath!)
                          : null,
                      child: authProvider.avatarPath == null
                          ? const Icon(Icons.person, size: 40)
                          : null,
                    ),

                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 18,
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _openAvatarPicker(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Center(
            child: Text(
              auth?.username ?? '',
              style: TextStyle(fontFamily: 'Gabarito', fontSize: 20),
            ),
          ),

          Spacer(),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: CustomButton(
              text: 'Logout',
              onPressed: () async {
                final authProvider = Provider.of<AuthApiProvider>(
                  context,
                  listen: false,
                );
                final favoriteProvider = Provider.of<FavoriteProvider>(
                  context,
                  listen: false,
                );
                final cocktailProvider = Provider.of<CocktailProvider>(
                  context,
                  listen: false,
                );

                // 1. Logout reale
                await authProvider.logout();

                // 2. Reset stato locale
                favoriteProvider.clear();
                cocktailProvider.clear();

                // 3. Navigazione pulita
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const MenuScreen()),
                  (_) => false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
