// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:service_laptop/component/notif.dart';
import 'package:service_laptop/model/users_model.dart';
import 'package:service_laptop/services/users_s.dart';
import 'package:service_laptop/util/colorapp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'login_c.dart';

class UsersC extends GetxController {
  final loginC = Get.put(LoginC());
  var isLoading = true.obs;
  var isShow = true.obs;
  var userList = List<Users>.empty().obs;
  var reviewerList = List<Users>.empty().obs;
  var listuserLogin = List<Users>.empty().obs;
  // final LoginC loginC = Get.put(LoginC());
  var levelU = "".obs;
  void setIsShow() {
    isShow(isShow.value == true ? false : true);
  }

  final nama = TextEditingController();
  final noTelp = TextEditingController();
  final password = TextEditingController();
  final email = TextEditingController();
  final level = TextEditingController();
  var fotoResult = "".obs;
  var idUserTemp = "".obs;
  var idU = "".obs;
  var foto = File("").obs;
  var statusUser = "".obs;

  final key = GlobalKey<FormState>();

  @override
  void onInit() {
    fetchUser();
    userLogin();
    super.onInit();
  }

  Users userById() {
    return userList.firstWhere((element) => element.idUser == idUserTemp.value);
  }

  Users profileUser() {
    return userList.firstWhere((element) => element.idUser == idU.value);
  }

  Future<Users> cekUsers() async {
    var res = await UserServices().detailUser(email: email.text);
    if (res != null) {
      nama.text = res.nama;
      // password.text = res.password;
      level.text = res.level;
      noTelp.text = res.noTelp;
      fotoResult.value = res.foto;
      statusUser.value = "1";
      idU.value = res.idUser;
      NotifApp().showToast("Data Sudah Ada");

      return res;
    } else {
      nama.text = "";
      password.text = "";
      level.text = "";
      noTelp.text = "";
      fotoResult.value = "";
      statusUser.value = "0";

      NotifApp().showToast("Data Belum Ada");

      return null;
    }
  }

  Future<Users> userLogin() async {
    // isLoading(true);
    var result;
    final pref = await SharedPreferences.getInstance();
    idU.value = pref.getString("idUser");
    levelU.value = pref.getString("level");
    try {
      var process = await UserServices().getUserById(id: idU.value);
      if (process != null) {
        result = process;
      } else {
        result = null;
      }
    } finally {
      isLoading(false);
    }

    return result;
  }

  Future<void> fetchUser() async {
    isLoading(true);
    try {
      var res = await UserServices().getUser();
      if (res != null) {
        userList.assignAll(res);
      } else {
        userList.assignAll([]);
      }
    } finally {
      isLoading(false);
    }

    return userList;
  }

  Future<void> fetchReviewer() async {
    isLoading(true);
    try {
      var res = await UserServices().getCustomer();
      if (res != null) {
        reviewerList.assignAll(res);
      } else {
        reviewerList.assignAll([]);
      }
    } finally {
      isLoading(false);
    }

    return reviewerList;
  }

  pickLampiran() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      foto.value = File(result.files.single.path);

      update();
    }
  }

  Future<void> uploadUser() async {
    isLoading(true);
    final form = key.currentState;

    form.save();
    try {
      List res = await UserServices.addUser(
        nama: nama.text,
        noTelp: noTelp.text,
        email: email.text,
        password: password.text,
        level: level.text,
        foto: foto.value,
      );

      if (res[0] == "berhasil") {
        NotifApp().showToast("Berhasil");

        foto.value = File("");
        nama.text = "";
        noTelp.text = "";
        email.text = "";
        password.text = "";

        level.text = "";

        // Get.back();
      } else {
        foto.value = File("");
        nama.text = "";
        noTelp.text = "";
        email.text = "";
        password.text = "";
        level.text = "";
        NotifApp().showToast("Gagal");
      }
      userList.refresh();
      fetchUser();
    } finally {
      isLoading(false);
    }
  }

  Future<String> editUser() async {
    isLoading(true);
    String response;
    final form = key.currentState;

    if (form.validate()) {
      form.save();

      try {
        var u = userById();
        List res = await UserServices.editUser(
          idUser: u.idUser,
          nama: nama.text == "" ? u.nama : nama.text,
          noTelp: noTelp.text == "" ? u.noTelp : noTelp.text,
          level: level.text == "" ? u.level : level.text,
          email: email.text == "" ? u.email : email.text,
          password: password.text == "" ? u.password : password.text,
          foto: foto.value,
        );

        if (res[0] == "berhasil") {
          userList.refresh();
          fetchUser();
          userById();
          foto.value = File("");
          nama.text = "";
          noTelp.text = "";
          email.text = "";
          password.text = "";
          level.text = "";

          NotifApp().showToast("Berhasil");
          foto.value = File("");
          Get.back(canPop: false);
          response = "Berhasil";
        } else {
          NotifApp().showToast("Gagal");
          // print(res[1]);
          response = "Gagal";
        }
      } finally {
        isLoading(false);
      }
    }
    return response;
  }

  Future deleteUser({String id}) async {
    try {
      isLoading(true);

      List res = await UserServices.deleteUser(id: id);

      if (res[0] == "berhasil") {
        userList.refresh();
        fetchUser();

        _showToast("Berhasil");

        Get.back();
      } else {
        _showToast("gagal");
      }
    } finally {
      isLoading(false);
    }
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: ColorApp.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void showDialog() {
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
        deleteUser(id: idUserTemp.value);
        // artikelList.refresh();
        // fetchInformasi();
      },
    );
  }

  void editName() {
    Get.defaultDialog(
      title: "Nama",
      content: Form(
          key: key,
          child: TextFormField(
            controller: nama,
            // initialValue: userById().nama,
          )),
      textCancel: "Batal",
      textConfirm: "Edit",
      buttonColor: ColorApp.primaryColor,
      cancelTextColor: ColorApp.primaryColor,
      confirmTextColor: Colors.white,
      onCancel: () {},
      onConfirm: () {
        editUser();
      },
    );
  }

  void editNidn() {
    Get.defaultDialog(
      title: "No.Telp",
      content: Form(
          key: key,
          child: TextFormField(
            controller: noTelp,
            // initialValue: userById().noTelp,
          )),
      textCancel: "Batal",
      textConfirm: "Edit",
      buttonColor: ColorApp.primaryColor,
      cancelTextColor: ColorApp.primaryColor,
      confirmTextColor: Colors.white,
      onCancel: () {},
      onConfirm: () {
        editUser();
      },
    );
  }

  void editEmail() {
    Get.defaultDialog(
      title: "Email",
      content: Form(
          key: key,
          child: TextFormField(
            controller: email,
            // initialValue: userById().email,
          )),
      textCancel: "Batal",
      textConfirm: "Edit",
      buttonColor: ColorApp.primaryColor,
      cancelTextColor: ColorApp.primaryColor,
      confirmTextColor: Colors.white,
      onCancel: () {},
      onConfirm: () {
        editUser();
      },
    );
  }

  void editPass() {
    Get.defaultDialog(
      title: "Password Baru",
      content: Form(
          key: key,
          child: TextFormField(
            controller: password,
            // initialValue: "",
          )),
      textCancel: "Batal",
      textConfirm: "Edit",
      buttonColor: ColorApp.primaryColor,
      cancelTextColor: ColorApp.primaryColor,
      confirmTextColor: Colors.white,
      onCancel: () {},
      onConfirm: () {
        editUser();
      },
    );
  }

  void editFoto() {
    Get.defaultDialog(
      title: "Foto",
      content: Form(
        key: key,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: foto.value.path != ""
                      ? Image.file(
                          foto.value,
                          width: 40.w,
                          height: 40.w,
                        )
                      : Text('Pilih Foto'),
                )),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: IconButton(
                onPressed: () => pickLampiran(),
                icon: Icon(
                  Icons.photo_library,
                  color: ColorApp.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
      textCancel: "Batal",
      textConfirm: "Edit",
      buttonColor: ColorApp.primaryColor,
      cancelTextColor: ColorApp.primaryColor,
      confirmTextColor: Colors.white,
      onCancel: () {
        foto.value = File("");
      },
      onConfirm: () {
        editUser();
      },
    );
  }

  void editLevel() {
    Get.defaultDialog(
      title: "Level User",
      content: Form(
        key: key,
        child: DropdownButtonFormField<String>(
          value: userById().level,
          hint: Text("Status User"),
          items: [
            DropdownMenuItem(
              child: Text("Admin"),
              value: "Admin",
            ),
            DropdownMenuItem(
              child: Text("Teknisi"),
              value: "Teknisi",
            ),
            DropdownMenuItem(
              child: Text("Customer"),
              value: "Customer",
            ),
          ],
          onChanged: (String value) {
            level.text = value;
          },
        ),
      ),
      textCancel: "Batal",
      textConfirm: "Edit",
      buttonColor: ColorApp.primaryColor,
      cancelTextColor: ColorApp.primaryColor,
      confirmTextColor: Colors.white,
      onCancel: () {},
      onConfirm: () {
        editUser();
      },
    );
  }
}
