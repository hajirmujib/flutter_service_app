import 'package:flutter/material.dart';

extension ColorApp on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  // static const Color primaryColor = Color(0xff3d42c6);
  static const Color greyColor = Color(0xffe8eaed);
  static const Color darkgreyColor = Color(0xff8a8b95);
  static const Color canvasColor = Color(0xfff5f7fb);
  // static const Color canvasColor = Color(0xffffffff);
  static const Color blackFont = Color(0xff393d54);
  static const Color shadowcolor = Color(0xffb0bec5);
  // static const Color bottonColor = Color(0xff4c45da);
  static const Color bottonColor = Color(0xff634ff8);
  // static const Color primaryColor = Color(0xff625ba6);
  static const Color primaryColor = Color(0xff634ff8);
  static const Color blueAccent = Color(0xffeff7fe);

  static const MaterialColor kPrimaryColor = MaterialColor(
    0xff3d42c6,
    <int, Color>{
      50: Color(0xff3d42c6),
      100: Color(0xff3d42c6),
      200: Color(0xff3d42c6),
      300: Color(0xff3d42c6),
      400: Color(0xff3d42c6),
      500: Color(0xff3d42c6),
      600: Color(0xff3d42c6),
      700: Color(0xff3d42c6),
      800: Color(0xff3d42c6),
      900: Color(0xff3d42c6),
    },
  );
}
