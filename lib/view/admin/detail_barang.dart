import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:service_laptop/component/appbarview.dart';
import 'package:service_laptop/component/boxcontainer.dart';
import 'package:service_laptop/component/list_title.dart';
import 'package:service_laptop/controller/barang_c.dart';
import 'package:service_laptop/controller/user_c.dart';
import 'package:service_laptop/util/colorapp.dart';
import 'package:service_laptop/util/textstyle.dart';
import 'package:sizer/sizer.dart';

class DetailBarang extends StatelessWidget {
  DetailBarang({Key key}) : super(key: key);
  final userC = Get.put(UsersC());
  final barangC = Get.put(BarangC());

  @override
  Widget build(BuildContext context) {
    // Users x = userC.userById();
    return Scaffold(
      backgroundColor: ColorApp.canvasColor,
      appBar: AppbarStyle(
        leading: InkWell(
          onTap: () {
            barangC.serialNumber.clear();
            barangC.seri.clear();
            barangC.jenisBarang.value = "";
            barangC.type.clear();
            Get.back();
          },
          child: LineIcon.arrowLeft(
            size: 7.w,
            color: ColorApp.primaryColor,
          ),
        ),
        title: Text(
          "DETAIL BARANG",
          style: AppbarTitle(),
        ),
      ),
      body: BoxContainer(
          fields: ListView(
        children: [
          Obx(() => ListItem(
                title: "Serial Number",
                subTitle: barangC.barangById().serialNumber,
                trailing: IconButton(
                  icon: LineIcon.edit(),
                  onPressed: () {
                    barangC.serialNumber.text =
                        barangC.barangById().serialNumber;
                    barangC.editSerialNumber();
                  },
                ),
              )),
          Obx(() => ListItem(
                title: "Seri",
                subTitle: barangC.barangById().seri,
                trailing: IconButton(
                  icon: LineIcon.edit(),
                  onPressed: () {
                    barangC.seri.text = barangC.barangById().seri;
                    barangC.editSeri();
                  },
                ),
              )),
          Obx(() => ListItem(
                title: "Type",
                subTitle: barangC.barangById().type,
                trailing: IconButton(
                  icon: LineIcon.edit(),
                  onPressed: () {
                    barangC.type.text = barangC.barangById().type;
                    barangC.editType();
                  },
                ),
              )),
          Obx(() => ListItem(
                title: "Jenis Barang",
                subTitle: barangC.barangById().jenisBarang,
                trailing: IconButton(
                  icon: LineIcon.edit(),
                  onPressed: () {
                    barangC.jenisBarang.value = barangC.barangById().kodeBarang;
                    barangC.editJenisBarang();
                  },
                ),
              )),

          // ListItem(
          //   title: "Password",
          //   subTitle: "******",
          //   trailing: IconButton(
          //     icon: LineIcon.edit(),
          //     onPressed: () {
          //       // userC.password.text = barangC.barangById().password;
          //       userC.editPass();
          //     },
          //   ),
          // ),
          // userC.levelU.value == "Admin" || userC.levelU.value == "admin"
          //     ? Obx(() => ListItem(
          //           title: "Level",
          //           subTitle: barangC.barangById().level,
          //           trailing: IconButton(
          //             icon: LineIcon.edit(),
          //             onPressed: () {
          //               // userC.level.text = userC.userById().level;
          //               userC.editLevel();
          //             },
          //           ),
          //         ))
          //     : const Text(""),
        ],
      )),
    );
  }
}
