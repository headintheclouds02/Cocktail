import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTapbar extends StatefulWidget {
  const CustomTapbar({super.key, this.currentIndex = 0, this.onTap});

  final int currentIndex;
  final Function(int)? onTap;

  @override
  State<CustomTapbar> createState() => _CustomTapbarState();
}

class _CustomTapbarState extends State<CustomTapbar> {

  @override
  Widget build(BuildContext context) {

    Color iconFocusedColor = AppColors.iconFocused;
    Color iconUnfocusedColor = AppColors.iconUnfocused;

    return SafeArea(
      child: Container(
        height: 80,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.tapBarBackground,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                'assets/img/icone/home.svg',
                width: 20,
                height: 20,
                color: widget.currentIndex == 0 ? iconFocusedColor : iconUnfocusedColor,
              ),
              onPressed: () {
                widget.onTap?.call(0);
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/img/icone/search.svg',
                width: 20,
                height: 20,
                color: widget.currentIndex == 1 ? iconFocusedColor : iconUnfocusedColor,
              ),
              onPressed: () {
                widget.onTap?.call(1);
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/img/icone/add1.svg',
                width: 30,
                height: 30,
                color: widget.currentIndex == 2 ? iconFocusedColor : iconUnfocusedColor,
              ),
              onPressed: () {
                widget.onTap?.call(2);
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/img/icone/cart1.svg',
                width: 20,
                height: 20,
                color: widget.currentIndex == 3 ? iconFocusedColor : iconUnfocusedColor,
              ),
              onPressed: () {
                widget.onTap?.call(3);
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/img/icone/profile.svg',
                width: 20,
                height: 20,
                color: widget.currentIndex == 4 ? iconFocusedColor : iconUnfocusedColor,
              ),
              onPressed: () {
                widget.onTap?.call(4);
              },
            ),
          ],
        ),
      ),
    );
  }
}
