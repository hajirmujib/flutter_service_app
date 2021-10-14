import 'package:get/get.dart';

class FormFieldC extends GetxController {
  var visibility = true.obs;

  void setIsShow() {
    visibility(visibility.value == true ? false : true);
  }
}
