import 'package:flutter/material.dart';
import 'package:service_laptop/util/colorapp.dart';
import 'package:sizer/sizer.dart';

class FotoRow extends StatelessWidget {
  const FotoRow({
    Key key,
    this.right,
    this.title,
    this.isi,
  }) : super(key: key);
  final Widget title;
  final Widget right;
  final Widget isi;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title,
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: ColorApp.greyColor,
                        borderRadius: BorderRadius.circular(10)),
                    width: 60.w,
                    height: 20.h,
                    child: Center(child: isi)),
                right,
              ],
            ),
          )
        ],
      ),
    );
  }
}
