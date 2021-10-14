import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:service_laptop/component/appbarview.dart';
import 'package:service_laptop/component/boxcontainer.dart';
import 'package:service_laptop/component/list_title.dart';
import 'package:service_laptop/controller/user_c.dart';
import 'package:service_laptop/services/base_services.dart';
import 'package:service_laptop/util/colorapp.dart';
import 'package:service_laptop/util/textstyle.dart';
import 'package:sizer/sizer.dart';

class DetailAkun extends StatelessWidget {
  DetailAkun({Key key}) : super(key: key);
  final userC = Get.put(UsersC());

  @override
  Widget build(BuildContext context) {
    // Users x = userC.userById();
    return Scaffold(
      backgroundColor: ColorApp.canvasColor,
      appBar: AppbarStyle(
        leading: InkWell(
          onTap: () {
            userC.email.clear();
            userC.nama.clear();
            userC.level.clear();
            userC.password.clear();
            userC.foto.value = File("");
            Get.back();
          },
          child: LineIcon.arrowLeft(
            size: 7.w,
            color: ColorApp.primaryColor,
          ),
        ),
        title: Text(
          "DETAIL AKUN",
          style: AppbarTitle(),
        ),
      ),
      body: BoxContainer(
          fields: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: InkWell(
              onTap: () {
                userC.editFoto();
              },
              child: CircleAvatar(
                radius: 15.w,
                child: Obx(() => CircleAvatar(
                      radius: 14.w,
                      backgroundImage: userC.userById().foto != ""
                          ? NetworkImage(BaseServices().urlFile +
                              "/service/fotoProfile/" +
                              userC.userById().foto)
                          : const AssetImage("assets/images/logo_github.png"),
                    )),
              ),
            ),
          ),
          Obx(() => ListItem(
                title: "Nama",
                subTitle: userC.userById().nama,
                trailing: IconButton(
                  icon: LineIcon.edit(),
                  onPressed: () {
                    userC.nama.text = userC.userById().nama;
                    userC.editName();
                  },
                ),
              )),
          Obx(() => ListItem(
                title: "Email",
                subTitle: userC.userById().email,
                trailing: IconButton(
                  icon: LineIcon.edit(),
                  onPressed: () {
                    userC.email.text = userC.userById().email;
                    userC.editEmail();
                  },
                ),
              )),
          Obx(() => ListItem(
                title: "No. Hp",
                subTitle: userC.userById().noTelp,
                trailing: IconButton(
                  icon: LineIcon.edit(),
                  onPressed: () {
                    userC.noTelp.text = userC.userById().noTelp;
                    userC.editNidn();
                  },
                ),
              )),
          ListItem(
            title: "Password",
            subTitle: "******",
            trailing: IconButton(
              icon: LineIcon.edit(),
              onPressed: () {
                // userC.password.text = userC.userById().password;
                userC.editPass();
              },
            ),
          ),
          userC.levelU.value == "Admin" || userC.levelU.value == "admin"
              ? Obx(() => ListItem(
                    title: "Level",
                    subTitle: userC.userById().level,
                    trailing: IconButton(
                      icon: LineIcon.edit(),
                      onPressed: () {
                        // userC.level.text = userC.userById().level;
                        userC.editLevel();
                      },
                    ),
                  ))
              : const Text(""),
        ],
      )),
    );
  }
}
