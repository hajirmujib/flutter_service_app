import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:service_laptop/component/appbarview.dart';
import 'package:service_laptop/component/list_title.dart';
import 'package:service_laptop/controller/user_c.dart';
import 'package:service_laptop/model/users_model.dart';
import 'package:service_laptop/services/base_services.dart';
import 'package:service_laptop/util/colorapp.dart';
import 'package:service_laptop/util/textstyle.dart';
import 'package:sizer/sizer.dart';

import '../add_user.dart';
import '../detail_akun.dart';

class UserV extends StatelessWidget {
  UserV({Key key}) : super(key: key);
  final userC = Get.put(UsersC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddUser(),
              duration: 0.5.seconds, transition: Transition.upToDown);
        },
        child: LineIcon.plus(),
      ),
      backgroundColor: ColorApp.canvasColor,
      appBar: AppbarStyle(
        title: Text("DAFTAR USER", style: AppbarTitle()),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: LineIcon.arrowLeft(
              color: ColorApp.primaryColor,
              size: 7.w,
            )),
        actions: [
          IconButton(
            onPressed: () {},
            icon: LineIcon.search(
              color: ColorApp.primaryColor,
              size: 7.w,
            ),
          )
        ],
      ),
      body: Obx(() => FutureBuilder(
          future: userC.fetchUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: userC.userList.length ?? 0,
                  itemBuilder: (context, i) {
                    Users x = userC.userList[i];
                    return Slidable(
                      actionPane: const SlidableDrawerActionPane(),
                      actions: [
                        IconButton(
                            onPressed: () {
                              userC.idUserTemp.value = x.idUser;
                              userC.showDialog();
                            },
                            icon: LineIcon.trash(color: Colors.red, size: 7.w)),
                      ],
                      child: InkWell(
                        onTap: () {
                          userC.idUserTemp.value = x.idUser;
                          // userC.nama.text = x.nama;
                          // userC.email.text = x.email;
                          // userC.noTelp.text = x.noTelp;
                          // userC.level.text = x.level;
                          Get.to(() => DetailAkun());
                        },
                        child: ListItem(
                          leading: CircleAvatar(
                            radius: 10.w,
                            backgroundColor: ColorApp.primaryColor,
                            backgroundImage: x.foto != ""
                                ? NetworkImage(
                                    BaseServices().urlFile +
                                        "/service/fotoProfile/" +
                                        x.foto,
                                  )
                                : const AssetImage(
                                    "assets/images/logo_github.png"),
                          ),
                          title: x.nama,
                          subTitle: x.level,
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          })),
    );
  }
}
