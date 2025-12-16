import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CustomTapbar extends StatefulWidget {
  const CustomTapbar({super.key});

  @override
  State<CustomTapbar> createState() => _CustomTapbarState();
}

class _CustomTapbarState extends State<CustomTapbar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 90,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                width: 30,
                height: 30,
              ),
              onPressed: () {
                print('Icona SVG cliccata!');
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/img/icone/search.svg',
                width: 30,
                height: 30,
              ),
              onPressed: () {
                print('Icona SVG cliccata!');
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/img/icone/add1.svg',
                width: 40,
                height: 40,
              ),
              onPressed: () {
                print('Icona SVG cliccata!');
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/img/icone/cart1.svg',
                width: 30,
                height: 30,
              ),
              onPressed: () {
                print('Icona SVG cliccata!');
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/img/icone/profile.svg',
                width: 30,
                height: 30,
              ),
              onPressed: () {
                print('Icona SVG cliccata!');
              },
            )
          ],
        ),
      ),
    );
  }
}
