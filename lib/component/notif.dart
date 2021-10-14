import 'package:fluttertoast/fluttertoast.dart';
import 'package:service_laptop/util/colorapp.dart';
import 'package:flutter/material.dart';

class NotifApp {
  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: ColorApp.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

 
}
