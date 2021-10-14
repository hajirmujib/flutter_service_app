import 'package:flutter/material.dart';
import 'package:service_laptop/util/textstyle.dart';
import 'package:sizer/sizer.dart';

class FormF extends StatelessWidget {
  const FormF(
      {Key key,
      this.controller,
      this.hintText,
      this.titleText,
      this.initialText,
      this.visibel,
      this.prefix,
      this.suffix})
      : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final String titleText;
  final String initialText;
  final Widget suffix;
  final bool visibel;
  final Widget prefix;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titleText, style: EmailProfile()),
          TextFormField(
              initialValue: initialText,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return "Tidak Boleh Kosong";
                }
                return null;
              },
              obscureText: visibel,
              controller: controller,
              style: AppbarTitle(),
              decoration: InputDecoration(
                  prefixIcon: prefix,
                  suffixIcon: suffix,
                  hintText: hintText,
                  hintStyle: HintText())),
        ],
      ),
    );
  }
}
