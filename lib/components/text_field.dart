import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_colors.dart';

class TextFieldCustom extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hintText;
  final TextEditingController? controller;
  final SvgPicture icon;
  final int minLines;
  final int maxLines;


  const TextFieldCustom({
    super.key,
    required this.onChanged,
    required this.hintText,
    this.controller,
    required this.icon,
    required this.minLines,
    required this.maxLines,
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
        minLines: minLines,
        maxLines: maxLines,
        cursorColor: AppColors.fieldText,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
