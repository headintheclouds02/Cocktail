import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        textStyle: TextStyle(fontSize: 25),
      ),
      child: Text(text, style: TextStyle(fontFamily: 'Gabarito')),
    );
  }
}
