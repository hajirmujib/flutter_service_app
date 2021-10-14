import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:service_laptop/component/appbarview.dart';
import 'package:service_laptop/component/childgrid.dart';
import 'package:service_laptop/component/drawer_profile.dart';
import 'package:service_laptop/controller/service_c.dart';
import 'package:service_laptop/util/textstyle.dart';
import 'package:service_laptop/view/admin/service_list.dart';
import 'package:service_laptop/view/admin/servicesatu.dart';
import 'package:service_laptop/view/admin/user_v.dart';
import 'package:sizer/sizer.dart';
import 'package:service_laptop/util/colorapp.dart';

import 'barang.dart';
import 'jenis_barang.dart';

class HomeView extends StatelessWidget {
  HomeView({Key key}) : super(key: key);
  final _key = GlobalKey<ScaffoldState>();
  final serviceC = Get.put(ServiceC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.canvasColor,
      key: _key,
      // ignore: prefer_const_constructors
      drawer: DrawerProfile(),
      appBar: AppbarStyle(
        leading: InkWell(
          onTap: () {
            _key.currentState.openDrawer();
          },
          child: LineIcon.bars(
            size: 7.w,
            color: ColorApp.primaryColor,
          ),
        ),
        title: Text(
          'DASHBOARD',
          style: AppbarTitle(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Text(
                "Service Center",
                style: HeadText(),
                textAlign: TextAlign.center,
              ),
            ),
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
                        Get.to(() => UserV(),
                            duration: 0.5.seconds,
                            transition: Transition.downToUp);
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: ChildGridMenu(
                            badge: "0",
                            titleGrid: "Daftar \nAkun",
                            iconGrid: SvgPicture.asset(
                              "assets/images/user.svg",
                              width: 15.w,
                              height: 15.w,
                            )),
                      ),
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 6,
                    md: 3,
                    child: InkWell(
                      onTap: () {
                        serviceC.statusTemp.value = "Service Baru";
                        Get.to(() => ServiceList(),
                            duration: 0.5.seconds,
                            transition: Transition.downToUp);
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Obx(() => ChildGridMenu(
                            badge: serviceC.jumlahService.value.toString(),
                            titleGrid: "Daftar \nService",
                            iconGrid: SvgPicture.asset(
                              "assets/images/innovation.svg",
                              width: 15.w,
                              height: 15.w,
                            ))),
                      ),
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 6,
                    md: 3,
                    child: InkWell(
                      onTap: () => Get.to(() => JenisBarangV(),
                          duration: 0.5.seconds,
                          transition: Transition.downToUp),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: ChildGridMenu(
                            badge: "0",
                            titleGrid: "Jenis \nBarang",
                            iconGrid: SvgPicture.asset(
                              "assets/images/presentation.svg",
                              width: 15.w,
                              height: 15.w,
                            )),
                      ),
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 6,
                    md: 3,
                    child: InkWell(
                      onTap: () => Get.to(() => BarangV(),
                          duration: 0.5.seconds,
                          transition: Transition.downToUp),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: ChildGridMenu(
                            badge: "0",
                            titleGrid: "Daftar \nBarang",
                            iconGrid: SvgPicture.asset(
                              "assets/images/package.svg",
                              width: 15.w,
                              height: 15.w,
                            )),
                      ),
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 6,
                    md: 3,
                    child: InkWell(
                      onTap: () => Get.to(() => StepSatu(),
                          transition: Transition.downToUp,
                          duration: 0.5.seconds),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: ChildGridMenu(
                            badge: "0",
                            titleGrid: "Service \nBaru",
                            iconGrid: SvgPicture.asset(
                              "assets/images/add-file.svg",
                              width: 15.w,
                              height: 15.w,
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
