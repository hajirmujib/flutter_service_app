import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_laptop/controller/login_c.dart';

class CekLogin extends StatelessWidget {
  CekLogin({Key key}) : super(key: key);
  final LoginC loginC = Get.put(LoginC());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loginC.goto(),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data;
          } else {
            return const Center(
              child: Text('Oops Ada Kesalahan'),
            );
          }
        });
  }
}
