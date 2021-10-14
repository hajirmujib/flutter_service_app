import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:service_laptop/component/formfield.dart';
import 'package:service_laptop/component/login_container.dart';
import 'package:service_laptop/controller/form_c.dart';
import 'package:service_laptop/util/colorapp.dart';
import 'package:service_laptop/util/textstyle.dart';
import 'package:sizer/sizer.dart';

import 'controller/login_c.dart';

class LoginView extends StatelessWidget {
  LoginView({Key key}) : super(key: key);

  final loginC = Get.put(LoginC());
  final keyLogin = GlobalKey<FormState>(debugLabel: 'error');
  final formC = Get.put(FormFieldC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        // margin: EdgeInsets.only(top: 10.h),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5.w),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Wellcome Back,",
                      style: NameStyle(),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Log in to continue,",
                      style: EmailProfile(),
                    )),
              ),
              Center(
                child: Image.asset(
                  "assets/images/signin.jpg",
                  height: 35.h,
                ),
              ),
              LoginContainer(
                fields: Form(
                  key: keyLogin,
                  child: Column(
                    children: [
                      FormF(
                        controller: loginC.usernameTxt,
                        titleText: "Email",
                        hintText: "Email",
                        prefix: LineIcon.user(),
                        visibel: false,
                      ),
                      Obx(() => FormF(
                          controller: loginC.passwordTxt,
                          titleText: "Password",
                          hintText: "Password",
                          prefix: LineIcon.key(),
                          visibel: formC.visibility.value,
                          suffix: IconButton(
                              onPressed: () {
                                formC.setIsShow();
                              },
                              icon: formC.visibility.value == false
                                  ? LineIcon.eye()
                                  : LineIcon.eyeSlash()))),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size.fromWidth(40.w),
                            primary: ColorApp.bottonColor,
                          ),
                          onPressed: () {
                            final form = keyLogin.currentState;
                            if (form.validate()) {
                              form.save();
                              loginC.fetchLogin();
                            }
                          },
                          child: Text(
                            "Log In",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppin Medium",
                                fontSize: 13.sp),
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
