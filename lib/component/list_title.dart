import 'package:flutter/material.dart';
import 'package:service_laptop/util/colorapp.dart';
import 'package:service_laptop/util/textstyle.dart';
import 'package:sizer/sizer.dart';

class ListItem extends StatelessWidget {
  const ListItem(
      {Key key, this.title, this.subTitle, this.leading, this.trailing})
      : super(key: key);

  final String title;
  final String subTitle;
  final Widget leading;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(2.h, 1.h, 2.h, 1.h),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 1.w,
                offset: Offset(1.w / 2, 1.w),
                color: ColorApp.greyColor,
                spreadRadius: 1.h / 3)
          ],
          border: Border.all(color: ColorApp.primaryColor),
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        enableFeedback: true,
        contentPadding: const EdgeInsets.all(5),
        minVerticalPadding: 5.0,
        leading: leading,
        subtitle: Text(subTitle, style: EmailProfile()),
        title: Text(
          title,
          style: NameStyle(),
        ),
        trailing: trailing,
      ),
    );
  }
}
