import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_laptop/component/formfield.dart';
import 'package:service_laptop/component/notif.dart';
import 'package:service_laptop/model/jenisbarangmodel.dart';
import 'package:service_laptop/services/jenis_barang_s.dart';
import 'package:service_laptop/util/colorapp.dart';
import 'package:service_laptop/util/textstyle.dart';
import 'package:sizer/sizer.dart';

class JenisBarangC extends GetxController {
  var isLoading = true.obs;
  var jenisBarangList = List<JenisBarang>.empty().obs;
  final jenisBarangTxt = TextEditingController();

  final editTxt = TextEditingController();

  final key = GlobalKey<FormState>();
  final keyEdit = GlobalKey<FormState>();

  // var idJenis = "".obs;

  @override
  void onInit() {
    fetchJenisBarang();
    super.onInit();
  }

  Future fetchJenisBarang() async {
    isLoading(true);
    try {
      var res = await JenisBarangS().getJenisBarang();
      if (res != null) {
        jenisBarangList.assignAll(res);
      } else {
        jenisBarangList.assignAll([]);
      }
    } finally {
      isLoading(false);
    }

    return jenisBarangList;
  }

  Future<void> addJenisBarang() async {
    isLoading(true);
    final form = key.currentState;

    if (form.validate()) {
      form.save();

      try {
        List res =
            await JenisBarangS.addJenisBarang(jenisBarang: jenisBarangTxt.text);

        if (res[0] == "berhasil") {
          jenisBarangTxt.text = "";
          NotifApp().showToast("Berhasil");

          Get.back();
        } else {
          NotifApp().showToast("Gagal");
        }
        jenisBarangList.refresh();
        fetchJenisBarang();
      } finally {
        isLoading(false);
      }
    }
  }

  Future<void> editJenisBarang({String id}) async {
    isLoading(true);
    final form = keyEdit.currentState;

    if (form.validate()) {
      form.save();

      try {
        List res = await JenisBarangS.editJenisBarang(
            jenisBarang: jenisBarangTxt.text, id: id);

        if (res[0] == "berhasil") {
          jenisBarangTxt.text = "";
          NotifApp().showToast("Berhasil");

          Get.back();
        } else {
          NotifApp().showToast("Gagal");
        }
        jenisBarangList.refresh();
        fetchJenisBarang();
      } finally {
        isLoading(false);
      }
    }
  }

  Future<void> deleteJenis({String id}) async {
    try {
      isLoading(true);

      List res = await JenisBarangS.deleteJenisBarang(id: id);

      if (res[0] == "berhasil") {
        jenisBarangList.refresh();
        fetchJenisBarang();

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
      title: "Edit Data",
      middleText: "",
      content: Form(
        key: keyEdit,
        child: SizedBox(
          width: 100.w,
          height: 15.h,
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: FormF(
              controller: jenisBarangTxt,
              titleText: "Jenis Barang",
              visibel: false,
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
        editJenisBarang(id: id);
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
              visibel: false,
              controller: jenisBarangTxt,
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
        addJenisBarang();
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
        deleteJenis(id: id);
      },
    );
  }
}
