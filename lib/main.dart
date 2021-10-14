import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_laptop/cek_login.dart';
import 'package:service_laptop/util/colorapp.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Sizer(builder: (context, orientation, deviceType) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Service Laptop',
      theme: ThemeData(
        primarySwatch: ColorApp.kPrimaryColor,
      ),
      home: Scaffold(
        body: CekLogin(),
      ),
    );
  }));
}
