import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:service_laptop/component/formfield.dart';
import 'package:service_laptop/component/notif.dart';
import 'package:service_laptop/model/barangmodel.dart';
import 'package:service_laptop/services/barang_s.dart';
import 'package:service_laptop/util/colorapp.dart';
import 'package:service_laptop/util/textstyle.dart';
import 'package:sizer/sizer.dart';

import 'jenis_barang_c.dart';

class BarangC extends GetxController {
  var isLoading = true.obs;
  final jenisBarangC = Get.put(JenisBarangC());
  var barangList = List<Barang>.empty().obs;
  final serialNumber = TextEditingController();
  final type = TextEditingController();
  final seri = TextEditingController();
  var jenisBarang = "".obs;
  final jenisBarangTxt = TextEditingController();
  final editTxt = TextEditingController();

  final key = GlobalKey<FormState>();
  final keyEdit = GlobalKey<FormState>();

  var statusBarang = "".obs;

  var idBarang = "".obs;
  var kodeBarang = "".obs;

  @override
  void onInit() {
    fetchBarang();
    super.onInit();
  }

  Barang barangById() {
    return barangList.firstWhere((element) => element.id == idBarang.value);
  }

  Future fetchBarang() async {
    isLoading(true);
    try {
      var res = await BarangS().getBarang();
      if (res != null) {
        barangList.assignAll(res);
      } else {
        barangList.assignAll([]);
      }
    } finally {
      isLoading(false);
    }

    return barangList;
  }

  Future<Barang> cekBarang() async {
    isLoading(true);
    try {
      var res = await BarangS().detailBarang(id: serialNumber.text);
      if (res != null) {
        serialNumber.text = res.serialNumber;
        seri.text = res.seri;
        type.text = res.type;
        // jenisBarang.value = res.jenisBarang;
        jenisBarang.value = res.kodeBarang;

        statusBarang.value = "1";
        NotifApp().showToast("Data Sudah Ada");
        return res;
      } else {
        // sn0serialNumber.text = "";
        seri.text = "";
        type.text = "";
        statusBarang.value = "0";
        jenisBarang.value = "";
        NotifApp().showToast("Data Belum Ada");
        return null;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> addBarang() async {
    isLoading(true);
    final form = key.currentState;

    if (form.validate()) {
      form.save();

      try {
        List res = await BarangS.addBarang(
            serialNumber: serialNumber.text,
            seri: seri.text,
            type: type.text,
            jenisBarang: jenisBarang.value);

        if (res[0] == "berhasil") {
          serialNumber.text = "";
          seri.text = "";
          type.text = "";
          jenisBarang.value = "";
          NotifApp().showToast("Berhasil");

          // Get.back();
        } else {
          NotifApp().showToast("Gagal");
        }
        barangList.refresh();
        fetchBarang();
      } finally {
        isLoading(false);
      }
    }
  }

  Future<void> editBarang({String id}) async {
    isLoading(true);
    final form = key.currentState;

    if (form.validate()) {
      form.save();

      try {
        List res = await BarangS.editBarang(
            serialNumber: serialNumber.text == ""
                ? barangById().serialNumber
                : serialNumber.text,
            seri: seri.text == "" ? barangById().seri : seri.text,
            type: type.text == "" ? barangById().type : type.text,
            jenisBarang: jenisBarang.value == ""
                ? barangById().jenisBarang
                : jenisBarang.value,
            id: idBarang.value);

        if (res[0] == "berhasil") {
          serialNumber.text = "";
          seri.text = "";
          type.text = "";
          jenisBarang.value = "";
          NotifApp().showToast("Berhasil");

          Get.back();
        } else {
          NotifApp().showToast("Gagal");
        }
        barangList.refresh();
        fetchBarang();
      } finally {
        isLoading(false);
      }
    }
  }

  Future<void> deleteBarang({String id}) async {
    try {
      isLoading(true);

      List res = await BarangS.deleteBarang(id: id);

      if (res[0] == "berhasil") {
        barangList.refresh();
        fetchBarang();

        NotifApp().showToast("Berhasil");

        Get.back();
      } else {
        NotifApp().showToast("gagal");
      }
    } finally {
      isLoading(false);
    }
  }

  void showEdit({String id}) {
    Get.defaultDialog(
      title: "Serial Number",
      middleText: "",
      content: Form(
        key: keyEdit,
        child: SizedBox(
          width: 100.w,
          height: 15.h,
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: FormF(
              controller: serialNumber,
              titleText: "Jenis Barang",
            ),
          ),
        ),
      ),
      textCancel: "Batal",
      textConfirm: "Edit",
      buttonColor: ColorApp.primaryColor,
      cancelTextColor: ColorApp.primaryColor,
      confirmTextColor: Colors.white,
      titleStyle: AppbarTitle(),
      onCancel: () {},
      onConfirm: () {
        editBarang(id: id);
      },
    );
  }

  void showAdd() {
    Get.defaultDialog(
      title: "Tambah Data",
      middleText: "",
      content: Form(
        key: key,
        child: SizedBox(
          width: 100.w,
          height: 15.h,
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: FormF(
              controller: serialNumber,
              titleText: "Jenis Barang",
            ),
          ),
        ),
      ),
      textCancel: "Batal",
      textConfirm: "Simpan",
      buttonColor: ColorApp.primaryColor,
      cancelTextColor: ColorApp.primaryColor,
      confirmTextColor: Colors.white,
      titleStyle: AppbarTitle(),
      onCancel: () {},
      onConfirm: () {
        addBarang();
      },
    );
  }

  void showDialog({String id}) {
    Get.defaultDialog(
      title: "Konfirmasi",
      middleText: "Yakin Ingin Menghapus?",
      textCancel: "Batal",
      textConfirm: "Hapus",
      buttonColor: ColorApp.primaryColor,
      cancelTextColor: ColorApp.primaryColor,
      confirmTextColor: Colors.white,
      onCancel: () {},
      onConfirm: () {
        deleteBarang(id: id);
      },
    );
  }

  void editSerialNumber() {
    Get.defaultDialog(
      title: "Serial Number",
      content: Form(
          key: key,
          child: TextFormField(
              controller: serialNumber,
              decoration: InputDecoration(
                suffixIcon: InkWell(
                    splashColor: Colors.amber,
                    onTap: () {
                      cekBarang();
                    },
                    child: LineIcon.search(color: ColorApp.primaryColor)),
              )
              // initialValue: userById().email,
              )),
      textCancel: "Batal",
      textConfirm: "Edit",
      buttonColor: ColorApp.primaryColor,
      cancelTextColor: ColorApp.primaryColor,
      confirmTextColor: Colors.white,
      onCancel: () {},
      onConfirm: () {
        editBarang();
      },
    );
  }

  void editSeri() {
    Get.defaultDialog(
      title: "Seri",
      content: Form(
          key: key,
          child: TextFormField(
            controller: seri,
            // initialValue: userById().email,
          )),
      textCancel: "Batal",
      textConfirm: "Edit",
      buttonColor: ColorApp.primaryColor,
      cancelTextColor: ColorApp.primaryColor,
      confirmTextColor: Colors.white,
      onCancel: () {},
      onConfirm: () {
        editBarang();
      },
    );
  }

  void editType() {
    Get.defaultDialog(
      title: "Type",
      content: Form(
          key: key,
          child: TextFormField(
            controller: type,
            // initialValue: userById().email,
          )),
      textCancel: "Batal",
      textConfirm: "Edit",
      buttonColor: ColorApp.primaryColor,
      cancelTextColor: ColorApp.primaryColor,
      confirmTextColor: Colors.white,
      onCancel: () {},
      onConfirm: () {
        editBarang();
      },
    );
  }

  void editJenisBarang() {
    Get.defaultDialog(
      title: "Level User",
      content: Form(
        key: key,
        child: Obx(() => DropdownButtonFormField<String>(
              value: jenisBarang.value != "" ? jenisBarang.value : null,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return "Tidak Boleh Kosong";
                }
                return null;
              },
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: ColorApp.greyColor),
                  ),
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
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
                jenisBarang.value = value;
              },
            )),
      ),
      textCancel: "Batal",
      textConfirm: "Edit",
      buttonColor: ColorApp.primaryColor,
      cancelTextColor: ColorApp.primaryColor,
      confirmTextColor: Colors.white,
      onCancel: () {},
      onConfirm: () {
        editBarang();
      },
    );
  }
}
