import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:service_laptop/component/appbarview.dart';
import 'package:service_laptop/component/boxcontainer.dart';
import 'package:service_laptop/component/fotorow.dart';
import 'package:service_laptop/component/notif.dart';
import 'package:service_laptop/controller/barang_c.dart';
import 'package:service_laptop/controller/service_c.dart';
import 'package:service_laptop/util/colorapp.dart';
import 'package:service_laptop/util/textstyle.dart';
import 'package:service_laptop/view/admin/servicetiga.dart';
import 'package:sizer/sizer.dart';
import 'package:service_laptop/component/formfield.dart';

class Servicedua extends StatelessWidget {
  Servicedua({Key key}) : super(key: key);
  final serviceC = Get.put(ServiceC());
  final barangC = Get.put(BarangC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.canvasColor,
      appBar: AppbarStyle(
        title: Column(
          children: [
            Text("KELENGKAPAN & KENDALA", style: AppbarTitle()),
            Text(
              "2/3",
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
          key: serviceC.key,
          child: ListView(
            children: [
              FormF(
                controller: serviceC.kendala,
                titleText: "Kendala",
                hintText: "Kendala",
                visibel: false,
              ),
              FormF(
                controller: serviceC.kelengkapan,
                hintText: "Kelengkapan",
                titleText: "Kelengkapan",
                visibel: false,
              ),
              Obx(() => FotoRow(
                    title: Text('Foto 1', style: EmailProfile()),
                    right: InkWell(
                        onTap: () {
                          serviceC.pickFoto1();
                        },
                        child: LineIcon.camera()),
                    isi: serviceC.foto1.value.path == ""
                        ? Text('Belum Ada File', style: EmailProfile())
                        : Image.file(File(serviceC.foto1.value.path)),
                  )),
              Obx(() => FotoRow(
                    title: Text('Foto 2', style: EmailProfile()),
                    right: InkWell(
                        onTap: () {
                          serviceC.pickFoto2();
                        },
                        child: LineIcon.camera()),
                    isi: serviceC.foto2.value.path == ""
                        ? Text('Belum Ada File', style: EmailProfile())
                        : Image.file(File(serviceC.foto2.value.path)),
                  )),
              Obx(() => FotoRow(
                    title: Text('Foto 3', style: EmailProfile()),
                    right: InkWell(
                        onTap: () {
                          serviceC.pickFoto3();
                        },
                        child: LineIcon.camera()),
                    isi: serviceC.foto3.value.path == ""
                        ? Text('Belum Ada File', style: EmailProfile())
                        : Image.file(File(serviceC.foto3.value.path)),
                  )),
              Padding(
                padding: EdgeInsets.all(3.h),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: ColorApp.primaryColor,
                      ),
                      onPressed: () {
                        if (serviceC.kendala.text == "" &&
                            serviceC.kelengkapan.text == "" &&
                            serviceC.foto1.value == null &&
                            serviceC.foto2.value == null &&
                            serviceC.foto3.value == null) {
                          NotifApp().showToast("Isi Data Dengan Lengkap");
                        } else {
                          if (barangC.statusBarang.value == "0") {
                            barangC.addBarang();
                          }
                          Get.to(() => ServiceTiga(),
                              duration: 0.5.seconds,
                              transition: Transition.leftToRight);
                        }
                      },
                      child: const Text("Selanjutnya")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
