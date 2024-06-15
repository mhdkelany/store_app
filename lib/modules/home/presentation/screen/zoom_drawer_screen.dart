import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:store/layout/layout_screen.dart';
import 'package:store/modules/other/other_screens/menu_screen.dart';
import 'package:store/shared/style/color.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      style: DrawerStyle.defaultStyle,
      menuScreen: MenuScreen(),
      mainScreen: LayoutScreen(),
      showShadow: true,
      isRtl: true,
      menuBackgroundColor: primaryColor,
    )
    ;
  }
}
