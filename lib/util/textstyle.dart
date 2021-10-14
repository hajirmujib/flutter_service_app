import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'colorapp.dart';

class StyleText extends TextStyle {}

class HeadText extends StyleText {
  @override
  // ignore: todo
  // TODO: implement color
  Color get color => ColorApp.blackFont;
  @override
  // ignore: todo
  // TODO: implement fontSize
  double get fontSize => 25.sp;
  @override
  // ignore: todo
  // TODO: implement fontWeight
  FontWeight get fontWeight => FontWeight.w500;
  @override
  // ignore: todo
  // TODO: implement fontFamily
  String get fontFamily => """
Poppin Semi Bold""";
}

class AppbarTitle extends StyleText {
  @override
  // ignore: todo
  // TODO: implement color
  Color get color => ColorApp.blackFont;
  @override
  // ignore: todo
  // TODO: implement fontSize
  double get fontSize => 15.sp;
  @override
  // ignore: todo
  // TODO: implement fontFamily
  String get fontFamily => "Poppin Medium";
}

class HintText extends StyleText {
  @override
  // ignore: todo
  // TODO: implement color
  Color get color => ColorApp.greyColor;
  @override
  // ignore: todo
  // TODO: implement fontSize
  double get fontSize => 15.sp;
  @override
  // ignore: todo
  // TODO: implement fontFamily
  String get fontFamily => "Poppin Medium";
}

class NameStyle extends StyleText {
  @override
  // ignore: todo
  // TODO: implement color
  Color get color => ColorApp.blackFont;
  @override
  // ignore: todo
  // TODO: implement fontSize
  double get fontSize => 15.sp;
  @override
  // ignore: todo
  // TODO: implement fontFamily
  String get fontFamily => "Poppin";
}

class EmailProfile extends StyleText {
  @override
  // ignore: todo
  // TODO: implement color
  Color get color => Colors.black54;
  @override
  // ignore: todo
  // TODO: implement fontSize
  double get fontSize => 13.sp;
  @override
  // ignore: todo
  // TODO: implement fontFamily
  String get fontFamily => "Poppin Medium";
}

class WhiteTextMedium extends StyleText {
  @override
  // ignore: todo
  // TODO: implement color
  Color get color => Colors.white70;
  @override
  // ignore: todo
  // TODO: implement fontSize
  double get fontSize => 13.sp;
  @override
  // ignore: todo
  // TODO: implement fontFamily
  String get fontFamily => "Poppin Medium";
}

class ChatTextWhite extends StyleText {
  @override
  // ignore: todo
  // TODO: implement color
  Color get color => Colors.white70;
  @override
  // ignore: todo
  // TODO: implement fontSize
  double get fontSize => 12.sp;
  @override
  // ignore: todo
  // TODO: implement fontFamily
  String get fontFamily => "Poppin Medium";
}

class ChatTextGrey extends StyleText {
  @override
  // ignore: todo
  // TODO: implement color
  Color get color => ColorApp.darkgreyColor;
  @override
  // ignore: todo
  // TODO: implement fontSize
  double get fontSize => 13.sp;
  @override
  // ignore: todo
  // TODO: implement fontFamily
  String get fontFamily => "Poppin Medium";
}

class StatusLogin extends StyleText {
  @override
  // ignore: todo
  // TODO: implement color
  Color get color => Colors.white70;
  @override
  // ignore: todo
  // TODO: implement fontSize
  double get fontSize => 13.sp;
  @override
  // ignore: todo
  // TODO: implement fontFamily
  String get fontFamily => """
Poppin Regular""";
}
