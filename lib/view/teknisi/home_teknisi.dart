import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:service_laptop/component/appbarview.dart';
import 'package:service_laptop/component/childgrid.dart';
import 'package:service_laptop/controller/login_c.dart';
import 'package:service_laptop/controller/service_c.dart';
import 'package:service_laptop/controller/user_c.dart';
import 'package:service_laptop/services/base_services.dart';
import 'package:service_laptop/util/textstyle.dart';
import 'package:service_laptop/view/teknisi/list_service_teknisi.dart';
import 'package:sizer/sizer.dart';
import 'package:service_laptop/util/colorapp.dart';

import '../../login_view.dart';
import '../detail_akun.dart';

class HomeTeknisiV extends StatelessWidget {
  HomeTeknisiV({Key key}) : super(key: key);
  final _key = GlobalKey<ScaffoldState>();
  final userC = Get.put(UsersC());
  final loginC = Get.put(LoginC());
  final serviceC = Get.put(ServiceC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.canvasColor,
      key: _key,
      // ignore: prefer_const_constructors

      appBar: AppbarStyle(
        title: Text(
          'SERVICE CENTER',
          style: AppbarTitle(),
        ),
        actions: [
          IconButton(
            icon: LineIcon.userCircle(
              color: ColorApp.primaryColor,
              size: 10.w,
            ),
            onPressed: () {
              userC.fetchUser();
              userC.idUserTemp.value = userC.idU.value;
              // print(userC.idU.value);
              Get.to(() => DetailAkun(),
                  transition: Transition.upToDown, duration: 0.5.seconds);
            },
          ),
          IconButton(
            icon: LineIcon.arrowCircleRight(
              color: ColorApp.primaryColor,
              size: 10.w,
            ),
            onPressed: () async {
              String res = await loginC.logOut();
              if (res != "") {
                Fluttertoast.showToast(msg: "Ada Kesalahan");
              } else {
                Get.offAll(LoginView());
                await loginC.logOut();
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            FutureBuilder(
                future: userC.userLogin(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        width: 100.w,
                        height: 35.h,
                        padding: EdgeInsets.fromLTRB(2.w, 5.h, 2.w, 1.w),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: ColorApp.primaryColor,
                                radius: 14.w,
                                child: CircleAvatar(
                                  radius: 13.w,
                                  backgroundImage: userC.profileUser().foto !=
                                          ""
                                      ? NetworkImage(BaseServices().urlFile +
                                          "/service/fotoProfile/" +
                                          userC.profileUser().foto)
                                      : const AssetImage(
                                          "assets/images/logo_github.png"),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Hi, " + userC.profileUser().nama,
                                  style: NameStyle(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: true,
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    userC.profileUser().email,
                                    style: EmailProfile(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
                  } else {
                    return CircleAvatar(
                        child: CircularProgressIndicator(value: 2.w));
                  }
                }),
            Container(
              width: 100.w,
              padding: EdgeInsets.fromLTRB(5.w, 5.w, 5.w, 5.w),
              child: ResponsiveGridRow(
                children: [
                  ResponsiveGridCol(
                    xs: 6,
                    md: 3,
                    child: InkWell(
                      onTap: () {
                        serviceC.statusTemp.value = "Service Baru";
                        serviceC.fetchServiceTeknisi();
                        Get.to(() => ServiceListTeknisi(),
                            duration: 0.5.seconds,
                            transition: Transition.upToDown);
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Obx(() => ChildGridMenu(
                              badge: serviceC.serviceNew.length.toString(),
                              titleGrid: "Service \nBaru",
                              iconGrid: LineIcon.laptopMedical(
                                color: ColorApp.primaryColor,
                                size: 20.w,
                              ),
                            )),
                      ),
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 6,
                    md: 3,
                    child: InkWell(
                      onTap: () {
                        serviceC.statusTemp.value = "Serviced";
                        serviceC.fetchServiceTeknisi();
                        Get.to(() => ServiceListTeknisi(),
                            duration: 0.5.seconds,
                            transition: Transition.upToDown);
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Obx(() => ChildGridMenu(
                              badge: serviceC.serviceServiced.length.toString(),
                              titleGrid: "Service",
                              iconGrid: LineIcon.tools(
                                color: ColorApp.primaryColor,
                                size: 20.w,
                              ),
                            )),
                      ),
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 6,
                    md: 3,
                    child: InkWell(
                      onTap: () {
                        serviceC.statusTemp.value = "Selesai";
                        serviceC.fetchServiceTeknisi();
                        Get.to(() => ServiceListTeknisi(),
                            duration: 0.5.seconds,
                            transition: Transition.upToDown);
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Obx(() => ChildGridMenu(
                              titleGrid: "History\nService",
                              badge: serviceC.serviceDone.length.toString(),
                              iconGrid: LineIcon.history(
                                color: ColorApp.primaryColor,
                                size: 20.w,
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
