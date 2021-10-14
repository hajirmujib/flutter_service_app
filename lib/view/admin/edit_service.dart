import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:service_laptop/component/appbarview.dart';
import 'package:service_laptop/component/boxcontainer.dart';
import 'package:service_laptop/component/formfield.dart';
import 'package:service_laptop/component/fotorow.dart';
import 'package:service_laptop/controller/barang_c.dart';
import 'package:service_laptop/controller/service_c.dart';
import 'package:service_laptop/services/base_services.dart';
import 'package:service_laptop/util/colorapp.dart';
import 'package:service_laptop/util/textstyle.dart';
import 'package:sizer/sizer.dart';

class EditService extends StatelessWidget {
  EditService({Key key}) : super(key: key);
  final serviceC = Get.put(ServiceC());
  final barangC = Get.put(BarangC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.canvasColor,
      appBar: AppbarStyle(
        title: Text("EDIT DETAIL SERVICE", style: AppbarTitle()),
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
              onPressed: () {
                serviceC.editService();
              },
              icon: LineIcon.check(
                color: ColorApp.primaryColor,
              ))
        ],
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
              FormF(
                controller: serviceC.kerusakan,
                hintText: "Kerusakan",
                titleText: "Kerusakan",
                visibel: false,
              ),
              FormF(
                controller: serviceC.biaya,
                hintText: "Biaya",
                titleText: "Biaya",
                visibel: false,
              ),
              Padding(
                padding: EdgeInsets.all(2.h),
                child: SizedBox(
                  width: 90.w,
                  height: 20.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Status", style: EmailProfile()),
                      DropdownButtonFormField<String>(
                        value: serviceC.status.text,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Tidak Boleh Kosong";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: ColorApp.greyColor),
                            ),
                            hintStyle: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                            fillColor: Colors.white,
                            filled: true),
                        isExpanded: true,
                        hint: const Text("Status"),
                        items: const [
                          DropdownMenuItem(
                            child: Text("Service Baru"),
                            value: "Service Baru",
                          ),
                          DropdownMenuItem(
                            child: Text("Serviced"),
                            value: "Serviced",
                          ),
                          DropdownMenuItem(
                            child: Text("Selesai"),
                            value: "Selesai",
                          ),
                        ],
                        onChanged: (String value) {
                          serviceC.status.text = value;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() => FotoRow(
                    title: Text('Foto 1', style: EmailProfile()),
                    right: InkWell(
                        onTap: () {
                          serviceC.pickFoto1();
                        },
                        child: LineIcon.camera()),
                    isi: serviceC.foto1.value.path == ""
                        ? serviceC.foto1Txt.value == ""
                            ? Text('Belum Ada File', style: EmailProfile())
                            : Image.network(BaseServices().urlFile +
                                "/service/kelengkapan/" +
                                serviceC.foto1Txt.value)
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
                        ? serviceC.foto2Txt.value == ""
                            ? Text('Belum Ada File', style: EmailProfile())
                            : Image.network(BaseServices().urlFile +
                                "/service/kelengkapan/" +
                                serviceC.foto2Txt.value)
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
                        ? serviceC.foto3Txt.value == ""
                            ? Text('Belum Ada File', style: EmailProfile())
                            : Image.network(BaseServices().urlFile +
                                "/service/kelengkapan/" +
                                serviceC.foto3Txt.value)
                        : Image.file(File(serviceC.foto3.value.path)),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
