import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool enableBackPress;

  const CustomAppBar({super.key, this.enableBackPress = false});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Row(
        children: [
          if (widget.enableBackPress)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.chevron_left, size: 24),
            ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: widget.enableBackPress ? 48 : 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: SizedBox(
                      width: 45,
                      height: 45,
                      child: Image.asset(
                        "assets/img/generic/logo_pnk_nobg.png",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      "Bevo, quindi sono",
                      style: TextStyle(fontFamily: 'Gabarito', fontSize: 22),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
