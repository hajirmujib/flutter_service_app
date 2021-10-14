import 'package:flutter/material.dart';
import 'package:service_laptop/util/colorapp.dart';
import 'package:sizer/sizer.dart';

class AppbarStyle extends StatelessWidget implements PreferredSizeWidget {
  AppbarStyle({
    Key key,
    this.actions,
    this.leading,
    this.title,
    this.appBar,
  }) : super(key: key);
  final Size pref = Size.fromHeight(2.h);
  final Widget leading;
  final Widget title;
  final AppBar appBar;
  final List<Widget> actions;

  // final Size pref;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      centerTitle: true,
      leading: leading,
      // flexibleSpace: Container(
      //   decoration: const BoxDecoration(
      //       image: DecorationImage(
      //         image: AssetImage(
      //           'assets/images/header.jpg',
      //         ),
      //         fit: BoxFit.cover,
      //       ),
      //       ),
      // ),
      actions: actions,
      backgroundColor: ColorApp.canvasColor,
      elevation: 0.0,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
