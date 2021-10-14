import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_laptop/services/login_s.dart';
import 'package:service_laptop/util/colorapp.dart';
import 'package:service_laptop/view/admin/home.dart';
import 'package:service_laptop/view/customer/home_customer.dart';
import 'package:service_laptop/view/teknisi/home_teknisi.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login_view.dart';
import 'form_c.dart';

class LoginC extends GetxController {
  // final UsersC userC = Get.put(UsersC());
  final formC = Get.put(FormFieldC());
  var loginProcess = false.obs;
  String username = "";
  var password = "";
  final usernameTxt = TextEditingController();
  final passwordTxt = TextEditingController();
  var error = "";
  var isShow = true.obs;
  // Widget level = ProfileLppmView();
  String idUser;
  var level = "".obs;

  void setIsShow() {
    isShow(isShow.value == true ? false : true);
  }

  Future<String> getIdUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return idUser = preferences.getString("idUser");
  }

  Future<Widget> goto() async {
    final pref = await SharedPreferences.getInstance();
    final value = pref.getString("status");
    level.value = pref.getString("level");
    formC.visibility(true);

    if (value == "login") {
      try {
        bool refresh = await this.refresh();
        if (refresh) {
          if (level.value == "Admin") {
            return HomeView();
          } else if (level.value == "Customer") {
            return HomeCustomerV();
          } else if (level.value == "Teknisi") {
            return HomeTeknisiV();
          }
          return HomeView();
        }
      } catch (e) {
        return LoginView();
      }
    }

    return LoginView();
  }

  Future<void> fetchLogin() async {
    try {
      loginProcess(true);
      List loginRes = await LoginS.login(
          email: usernameTxt.text, password: passwordTxt.text);

      if (loginRes[0] == "login") {
        error = loginRes[0];
        final pref = await SharedPreferences.getInstance();
        pref.setString("status", loginRes[0]);
        pref.setString("idUser", loginRes[1]);
        pref.setString("level", loginRes[2]);
        level.value = loginRes[2];
        if (level.value == "Admin") {
          Get.to(HomeView(), transition: Transition.upToDown);
        } else if (level.value == "Customer") {
          Get.to(HomeCustomerV(), transition: Transition.upToDown);
        } else if (level.value == "Teknisi") {
          Get.to(HomeTeknisiV(), transition: Transition.upToDown);
        }

        usernameTxt.clear();
        passwordTxt.clear();
      } else {
        error = loginRes[1];

        showDialog();
      }
    } finally {
      loginProcess(false);
    }
  }

  @override
  Future<bool> refresh() async {
    final pref = await SharedPreferences.getInstance();
    String token = pref.getString("status");

    if (token == "") {
      return false;
    }

    bool succes = false;
    try {
      loginProcess(true);
      if (token != null) {
        succes = true;
      }
    } finally {
      loginProcess(false);
    }

    return succes;
  }

  Future<String> logOut() async {
    var succes = "";

    final pref = await SharedPreferences.getInstance();
    pref.remove("level");
    pref.remove("idUser");
    pref.remove("status");

    pref.setString("status", "");
    pref.setString("idUser", "");
    pref.setString("level", "");

    formC.visibility(true);

    usernameTxt.clear();
    passwordTxt.clear();
    return succes;
  }

  void showDialog() {
    Get.defaultDialog(
      title: "Status Login Gagal",
      middleText: "Password / Email Salah",
      textCancel: "Oke",
      buttonColor: ColorApp.primaryColor,
      cancelTextColor: ColorApp.primaryColor,
      confirmTextColor: Colors.white,
      onCancel: () {},
    );
  }
}
