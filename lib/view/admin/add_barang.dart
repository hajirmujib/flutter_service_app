import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:service_laptop/component/appbarview.dart';
import 'package:service_laptop/component/boxcontainer.dart';
import 'package:service_laptop/component/formfield.dart';
import 'package:service_laptop/component/notif.dart';
import 'package:service_laptop/controller/barang_c.dart';
import 'package:service_laptop/controller/jenis_barang_c.dart';
import 'package:service_laptop/controller/service_c.dart';
import 'package:service_laptop/util/colorapp.dart';
import 'package:service_laptop/util/textstyle.dart';
import 'package:sizer/sizer.dart';

class AddBarang extends StatelessWidget {
  AddBarang({Key key}) : super(key: key);
  final serviceC = Get.put(ServiceC());
  final jenisBarangC = Get.put(JenisBarangC());
  final barangC = Get.put(BarangC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.canvasColor,
      appBar: AppbarStyle(
        title: Text("TAMBAH BARANG", style: AppbarTitle()),
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
          key: barangC.key,
          child: ListView(
            children: [
              FormF(
                hintText: "Serial Number",
                titleText: "Serial Number",
                visibel: false,
                controller: barangC.serialNumber,
                suffix: InkWell(
                    splashColor: Colors.amber,
                    onTap: () {
                      barangC.cekBarang();
                    },
                    child: LineIcon.search(color: ColorApp.primaryColor)),
              ),
              FormF(
                titleText: "Seri",
                hintText: "Seri",
                visibel: false,
                controller: barangC.seri,
              ),
              FormF(
                titleText: "Type",
                hintText: "Type",
                controller: barangC.type,
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
                      Text("Jenis", style: EmailProfile()),
                      Obx(() => DropdownButtonFormField<String>(
                            value: barangC.jenisBarang.value != ""
                                ? barangC.jenisBarang.value
                                : null,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return "Tidak Boleh Kosong";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: ColorApp.greyColor),
                                ),
                                hintStyle: const TextStyle(
                                    color: Colors.grey, fontSize: 18),
                                fillColor: Colors.white,
                                filled: true),
                            isExpanded: true,
                            hint: const Text("Jenis Barang"),
                            items: jenisBarangC.jenisBarangList.map(
                              (element) {
                                return DropdownMenuItem(
                                  child: Text(element.jenisBarang),
                                  value: element.kodeBarang,
                                );
                              },
                            ).toList(),
                            onChanged: (String value) {
                              barangC.jenisBarang.value = value;
                            },
                          )),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: ColorApp.primaryColor),
                    onPressed: () {
                      if (barangC.serialNumber.text != "" &&
                          barangC.seri.text != "" &&
                          barangC.type.text != "" &&
                          barangC.jenisBarang.value != "") {
                        serviceC.serialNumber.text = barangC.serialNumber.text;
                        barangC.addBarang();
                      } else {
                        NotifApp().showToast("Isi Data Barang Dengan Lengkap");
                      }
                    },
                    child: const Text("Simpan")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
