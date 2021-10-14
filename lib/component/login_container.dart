import 'package:flutter/material.dart';
import 'package:service_laptop/util/colorapp.dart';
import 'package:sizer/sizer.dart';

class LoginContainer extends StatelessWidget {
  const LoginContainer({
    Key key,
    this.fields,
  }) : super(key: key);

  final Widget fields;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 90.w,
          margin: EdgeInsets.fromLTRB(2.w, 2.w, 2.w, 0),
          decoration: const BoxDecoration(
              color: ColorApp.bottonColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: const Text(""),
        ),
        Container(
            padding: EdgeInsets.all(2.w),
            margin: EdgeInsets.fromLTRB(2.w, 0, 2.w, 2.w),
            width: 90.w,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 1.w,
                      offset: Offset(1.w / 2, 1.w),
                      color: ColorApp.greyColor,
                      spreadRadius: 1.h / 3)
                ],
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: fields),
      ],
    );
  }
}
