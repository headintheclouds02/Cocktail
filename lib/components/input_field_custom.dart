import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_colors.dart';

class InputFieldCustom extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hintText;
  final TextEditingController? controller;
  final SvgPicture? icon;
  final bool hideText;
  final Widget? suffixIcon;



  const InputFieldCustom({
    super.key,
    required this.onChanged,
    required this.hintText,
    this.controller,
    required this.icon,
    required this.hideText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.searchBar,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        obscureText: hideText,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          icon: icon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
