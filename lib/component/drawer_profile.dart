// ignore: file_names
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:service_laptop/controller/login_c.dart';
import 'package:service_laptop/controller/user_c.dart';
import 'package:service_laptop/services/base_services.dart';
import 'package:service_laptop/util/colorapp.dart';
import 'package:service_laptop/util/textstyle.dart';
import 'package:service_laptop/view/detail_akun.dart';
import 'package:sizer/sizer.dart';
import '../login_view.dart';

class DrawerProfile extends StatelessWidget {
  DrawerProfile({
    Key key,
  }) : super(key: key);
  final userC = Get.put(UsersC());
  final loginC = Get.put(LoginC());
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.grey.shade100),
      child: Drawer(
        elevation: 0.0,
        child: ListView(
          children: [
            FutureBuilder(
                future: userC.userLogin(),
                builder: (context, snapshot) {
                  // Users x = snapshot.data;
                  if (snapshot.hasData) {
                    return Container(
                        width: 100.w,
                        height: 40.h,
                        padding: EdgeInsets.fromLTRB(2.w, 5.h, 2.w, 2.w),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 11.w,
                              backgroundColor: ColorApp.primaryColor,
                              child: Obx(() => CircleAvatar(
                                    radius: 10.w,
                                    backgroundImage: userC.profileUser().foto !=
                                            ""
                                        ? NetworkImage(BaseServices().urlFile +
                                            "/service/fotoProfile/" +
                                            userC.profileUser().foto)
                                        : const AssetImage(
                                            "assets/images/logo_github.png"),
                                  )),
                            ),
                            Obx(() => Text(
                                  userC.profileUser().nama,
                                  style: NameStyle(),
                                )),
                            Obx(() => Text(userC.profileUser().email,
                                style: EmailProfile())),
                            Container(
                              margin: EdgeInsets.only(top: 2.h),
                              padding: const EdgeInsets.all(2.0),
                              width: 40.w,
                              decoration: BoxDecoration(
                                  color: ColorApp.primaryColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Obx(() => Center(
                                  child: Text(userC.profileUser().level,
                                      style: WhiteTextMedium()))),
                            )
                          ],
                        ));
                  } else {
                    return CircleAvatar(
                        radius: 10.w, child: const CircularProgressIndicator());
                  }
                }),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: InkWell(
                onTap: () {
                  userC.idUserTemp.value = userC.idU.value;
                  Get.to(() => DetailAkun());
                },
                child: ListTile(
                  leading: LineIcon.cog(
                    color: Colors.blue.shade400,
                  ),
                  title: Text(
                    "Setting",
                    style: EmailProfile(),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                String res = await loginC.logOut();
                if (res != "") {
                  Fluttertoast.showToast(msg: "Ada Kesalahan");
                } else {
                  Get.offAll(LoginView());
                  await loginC.logOut();
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.red.shade400,
                  ),
                  title: Text(
                    "Log Out",
                    style: EmailProfile(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
