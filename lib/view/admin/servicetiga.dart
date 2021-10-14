import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:service_laptop/component/appbarview.dart';
import 'package:service_laptop/component/boxcontainer.dart';
import 'package:service_laptop/component/fotorow.dart';
import 'package:service_laptop/controller/service_c.dart';
import 'package:service_laptop/controller/user_c.dart';
import 'package:service_laptop/services/base_services.dart';
import 'package:service_laptop/util/colorapp.dart';
import 'package:service_laptop/util/textstyle.dart';
import 'package:service_laptop/view/admin/home.dart';
import 'package:sizer/sizer.dart';
import 'package:service_laptop/component/formfield.dart';

class ServiceTiga extends StatelessWidget {
  ServiceTiga({Key key}) : super(key: key);
  final serviceC = Get.put(ServiceC());
  final usersC = Get.put(UsersC());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.canvasColor,
      appBar: AppbarStyle(
        title: Column(
          children: [
            Text("IDENTITAS PELANGGAN", style: AppbarTitle()),
            Text(
              "3/3",
              style: EmailProfile(),
            )
          ],
        ),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: LineIcon.arrowLeft(
              color: ColorApp.primaryColor,
              size: 7.w,
            )),
      ),
      body: BoxContainer(
        fields: Form(
          key: usersC.key,
          child: ListView(
            children: [
              FormF(
                hintText: "Email",
                titleText: "Email",
                visibel: false,
                controller: usersC.email,
                suffix: InkWell(
                  onTap: () {
                    usersC.cekUsers();
                  },
                  child: LineIcon.search(
                    color: ColorApp.primaryColor,
                  ),
                ),
              ),
              Obx(() => FotoRow(
                    title: Text('Foto Profile', style: EmailProfile()),
                    right: InkWell(
                        onTap: () {
                          usersC.pickLampiran();
                        },
                        child: LineIcon.photoVideo()),
                    isi: usersC.fotoResult.value != "" &&
                            usersC.fotoResult.value != null
                        ? Image.network(
                            BaseServices().urlFile +
                                "/service/fotoProfile/" +
                                usersC.fotoResult.value,
                            fit: BoxFit.cover)
                        : usersC.foto.value.path == ""
                            ? Text("Belum Ada Foto", style: EmailProfile())
                            : Image.file(usersC.foto.value),
                  )),
              FormF(
                titleText: "Nama",
                hintText: "Nama",
                visibel: false,
                controller: usersC.nama,
              ),
              FormF(
                  hintText: "No. Telp",
                  titleText: "NoTelp",
                  visibel: false,
                  controller: usersC.noTelp),
              FormF(
                  hintText: "Password",
                  titleText: "Password",
                  visibel: false,
                  controller: usersC.password),
              Center(
                child: Obx(() => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: usersC.statusUser.value == "0"
                          ? ColorApp.primaryColor
                          : Colors.grey,
                      minimumSize: Size(70.w, 8.h),
                    ),
                    onPressed: () {
                      usersC.level.text = "Customer";
                      usersC.statusUser.value == "0"
                          ? usersC.uploadUser()
                          : null;
                    },
                    child: const Text("Buat Akun"))),
              ),
              Padding(
                padding: EdgeInsets.all(3.h),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: usersC.statusUser.value != "0"
                            ? ColorApp.primaryColor
                            : Colors.grey,
                      ),
                      onPressed: () {
                        serviceC.uploadService();
                        Get.to(() => HomeView(),
                            duration: 0.5.seconds,
                            transition: Transition.upToDown);
                        usersC.email.clear();
                        usersC.nama.clear();
                        usersC.noTelp.clear();
                        usersC.password.clear();
                        usersC.fotoResult.value = "";
                      },
                      child: const Text("Selesai")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
