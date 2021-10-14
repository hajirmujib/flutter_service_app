import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:service_laptop/util/colorapp.dart';
import 'package:service_laptop/util/textstyle.dart';
import 'package:sizer/sizer.dart';

class ChildGridMenu extends StatelessWidget {
  const ChildGridMenu({
    Key key,
    this.titleGrid,
    this.iconGrid,
    this.badge,
    this.color,
  }) : super(key: key);

  final String titleGrid;
  final Widget iconGrid;
  final String badge;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 23.h,
      width: 40.w,
      margin: EdgeInsets.all(3.h),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 1.w,
                offset: Offset(1.w / 2, 1.w),
                color: ColorApp.greyColor,
                spreadRadius: 1.h / 3)
          ],
          color: Colors.white,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(2.w),
            child: Badge(
              showBadge: badge == "0" ? false : true,
              padding: EdgeInsets.all(2.w),
              badgeContent: Text(
                badge ?? "",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconGrid,
                Text(
                  titleGrid,
                  style: AppbarTitle(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
