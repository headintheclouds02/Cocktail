import 'package:flutter/material.dart';
import 'package:flutter_cocktail/components/custom_button.dart';

import 'menu_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("ciao"),
        CustomButton(text: 'Logout', onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MenuScreen()),
                (route) => false,
          );
        })
      ],
    );
  }
}
