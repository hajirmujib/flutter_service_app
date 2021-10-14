// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_laptop/component/notif.dart';
import 'package:service_laptop/controller/user_c.dart';
import 'package:service_laptop/model/servicemodel.dart';
import 'package:service_laptop/services/service_s.dart';
import 'package:service_laptop/util/colorapp.dart';

class ServiceC extends GetxController {
  final userC = Get.put(UsersC());
  var isLoading = true.obs;
  var loadingDetail = true.obs;
  var loadingCustomer = true.obs;
  var loadingCustomerNew = true.obs;
  var isShow = true.obs;
  var serviceList = List<Service>.empty().obs;
  // var serviceNew = List<Service>.empty().obs;
  var serviceDone = List<Service>.empty().obs;
  var serviceServiced = List<Service>.empty().obs;
  var serviceCustomerNew = List<Service>.empty().obs;
  var serviceCustomerDone = List<Service>.empty().obs;
  // var serviceCustomerServiced = List<Service>().obs;
  RxList<Service> serviceCustomerServiced = <Service>[].obs;
  RxList<Service> serviceNew = <Service>[].obs;

  final serialNumber = TextEditingController();
  final kendala = TextEditingController();
  final kelengkapan = TextEditingController();
  final kerusakan = TextEditingController();
  final biaya = TextEditingController();
  final status = TextEditingController();
  final idUser = TextEditingController();

  var tglMasuk = "".obs;
  var kodeService = "".obs;
  var tglKeluar = "".obs;
  var idService = "".obs;
  var foto1Txt = "".obs;
  var foto2Txt = "".obs;
  var foto3Txt = "".obs;
  var foto1 = XFile("").obs;
  var foto2 = XFile("").obs;
  var foto3 = XFile("").obs;
  var jumlahService = 0.obs;

  //field status for api
  var statusTemp = "".obs;

  final ImagePicker _picker = ImagePicker();

  final key = GlobalKey<FormState>();
  @override
  void onInit() {
    // cekJumlahServiceCustomer();
    super.onInit();
    fetchService();
    fetchServiceBaru();
    fetchServiceSelesai();
    fetchServiceServiced();
    fetchServiceCustomerDone();
    fetchServiceCustomerNew();
    fetchServiceCustomerServiced();
    jumlahServiceC();
  }

  // @override
  // void onInit() {

  //   super.onInit();
  // }

  // void setSelected(String value){
  //    selected.value = value;
  //  }

  Service serviceById() {
    return serviceList
        .firstWhere((element) => element.idService == idService.value);
  }

  Future<Service> servicedetail() async {
    Service response;

    try {
      var res = await ServiceS().getServiceById(id: idService.value);

      if (res != null) {
        response = res;
      }
    } catch (e) {
      e.toString();
    }
    return response;
  }

  Future jumlahServiceC() async {
    await fetchServiceBaru().then((value) async {
      await fetchServiceServiced().then((value) {
        var process = serviceNew.length + serviceServiced.length;
        jumlahService.value = process;
      });
    });
  }

  Future<void> fetchService() async {
    isLoading(true);
    try {
      var res = await ServiceS.getService();
      if (res != null) {
        serviceList.assignAll(res);
      } else {
        serviceList.assignAll([]);
      }
    } finally {
      isLoading(false);
    }

    return serviceList;
  }

  // Future<void> fetchServiceUser() async {
  //   loadingDetail(true);
  //   try {
  //     var res = await ServiceS()
  //         .getSericeCustomer(idU: UsersC().idU.value, status: statusTemp.value);
  //     if (res != null) {
  //       serviceList.assignAll(res);
  //     } else {
  //       serviceList.assignAll([]);
  //     }
  //   } finally {
  //     isLoading(false);
  //   }

  //   return serviceList;
  // }

  Future<void> fetchServiceCustomerDone() async {
    loadingCustomer(true);
    try {
      var res = await ServiceS.getSericeCustomer(
          idU: userC.idU.value, status: "Selesai");
      if (res != null) {
        serviceCustomerDone.assignAll(res);
      } else {
        serviceCustomerDone.assignAll([]);
      }
    } finally {
      loadingCustomer(false);
    }

    return serviceCustomerDone;
  }

  Future<void> fetchServiceCustomerNew() async {
    loadingCustomerNew(true);
    try {
      var res = await ServiceS.getSericeCustomer(
          idU: userC.idU.value, status: "Service Baru");
      if (res != null) {
        serviceCustomerNew.assignAll(res);
      } else {
        serviceCustomerNew.assignAll([]);
      }
    } finally {
      loadingCustomerNew(false);
    }

    return serviceCustomerNew;
  }

  Future<void> fetchServiceCustomerServiced() async {
    loadingCustomer(true);
    try {
      var res = await ServiceS.getSericeCustomer(
          idU: userC.idU.value, status: "Serviced");
      if (res != null) {
        serviceCustomerServiced.assignAll(res);
      } else {
        serviceCustomerServiced.assignAll([]);
      }
    } finally {
      loadingCustomer(false);
    }

    return serviceCustomerServiced;
  }

  Future<void> fetchServiceSelesai() async {
    loadingDetail(true);
    try {
      var res = await ServiceS.getSericeStatus(status: "Selesai");
      if (res != null) {
        serviceDone.assignAll(res);
      } else {
        serviceDone.assignAll([]);
      }
    } finally {
      loadingDetail(false);
    }

    return serviceDone;
  }

  Future<List<Service>> fetchServiceBaru() async {
    try {
      var res = await ServiceS.getSericeStatus(status: "Service Baru");
      if (res != null) {
        serviceNew.assignAll(res);
      } else {
        serviceNew.assignAll([]);
      }
    } catch (e) {
      e.toString();
    }

    return serviceNew;
  }

  Future fetchServiceServiced() async {
    try {
      var res = await ServiceS.getSericeStatus(status: "Serviced");
      if (res != null) {
        serviceServiced.assignAll(res);
      } else {
        serviceServiced.assignAll([]);
      }
    } catch (e) {
      e.toString();
    }

    return serviceServiced;
  }

  Future<void> fetchServiceTeknisi() async {
    try {
      var res = await ServiceS.getSericeStatus(status: statusTemp.value);
      if (res != null) {
        serviceList.assignAll(res);
      } else {
        serviceList.assignAll([]);
      }
    } catch (e) {
      e.toString();
    }

    return serviceList;
  }

  pickFoto1() async {
    // FilePickerResult result = await FilePicker.platform.pickFiles();
    // if (result != null) {
    //   foto1.value = File(result.files.single.path);

    //   update();
    // }

    final XFile photo =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 0);

    if (photo != null) {
      foto1.value = photo;
    }
  }

  pickFoto2() async {
    // FilePickerResult result = await FilePicker.platform.pickFiles();
    // if (result != null) {
    //   foto2.value = File(result.files.single.path);

    //   update();
    // }

    final XFile photo =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 0);

    if (photo != null) {
      foto2.value = photo;
    }
  }

  pickFoto3() async {
    // FilePickerResult result = await FilePicker.platform.pickFiles();
    // if (result != null) {
    //   foto3.value = File(result.files.single.path);

    //   update();
    // }

    final XFile photo =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 0);

    if (photo != null) {
      foto3.value = photo;
    }
  }

  Future<void> uploadService() async {
    isLoading(true);
    final form = key.currentState;

    form.save();

    try {
      List res = await ServiceS.addService(
        serialNumber: serialNumber.text,
        kendala: kendala.text,
        kelengkapan: kelengkapan.text,
        kerusakan: kerusakan.text,
        foto1: foto1.value,
        foto2: foto2.value,
        foto3: foto3.value,
        idUser: idUser.text,
      );

      if (res[0] == "berhasil") {
        NotifApp().showToast("Berhasil");

        serialNumber.clear();
        kendala.clear();
        kerusakan.clear();
        kelengkapan.clear();
        biaya.text = "";
        idUser.text = "";
        foto1.value = XFile("");
        foto2.value = XFile("");
        foto3.value = XFile("");

        serviceNew.refresh();
        fetchServiceBaru();
        fetchService();
        jumlahServiceC();

        // Get.offAll(() => HomeView());
      } else {
        serialNumber.clear();
        kendala.clear();
        kerusakan.clear();
        kelengkapan.clear();
        biaya.clear();
        idUser.clear();
        foto1.value = XFile("");
        foto2.value = XFile("");
        foto3.value = XFile("");
        key.currentState.reset();
        NotifApp().showToast("Gagal");
      }
      serviceList.refresh();
      fetchService();
    } finally {
      isLoading(false);
    }
  }

  Future<String> editService() async {
    isLoading(true);
    String response;
    final form = key.currentState;

    if (form.validate()) {
      form.save();

      try {
        List res = await ServiceS.editService(
          serialNumber: serialNumber.text,
          kodeService: kodeService.value,
          kendala: kendala.text,
          kelengkapan: kelengkapan.text,
          kerusakan: kerusakan.text,
          biaya: biaya.text,
          foto1: foto1.value,
          foto2: foto2.value,
          foto3: foto3.value,
          idUser: idUser.text,
          idService: idService.value,
          tglMasuk: tglMasuk.value,
          tglKeluar: tglKeluar.value,
          status: status.text,
        );
        if (res[0] == "berhasil") {
          serialNumber.clear();
          kendala.clear();
          kerusakan.clear();
          kelengkapan.clear();
          biaya.clear();
          idUser.clear();
          foto1.value = XFile("");
          foto2.value = XFile("");
          foto3.value = XFile("");
          // serviceById();
          //Servicedetail();
          // serviceList.refresh();
          serviceDone.refresh();
          serviceNew.refresh();
          serviceServiced.refresh();
          fetchServiceBaru();
          fetchServiceSelesai();
          fetchServiceServiced();
          fetchService();
          jumlahServiceC();
          // fetchServiceTeknisi();
          // fetchService();

          NotifApp().showToast("Berhasil");
          Get.back(canPop: false);
          response = "Berhasil";
        } else {
          NotifApp().showToast("Gagal");
          response = "Gagal";
        }
      } finally {
        isLoading(false);
      }
    }
    return response;
  }

  Future deleteService({String id}) async {
    try {
      isLoading(true);

      List res = await ServiceS.deleteService(id: id);

      if (res[0] == "berhasil") {
        serviceList.refresh();
        fetchService();

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
        deleteService(id: idService.value);
        // artikelList.refresh();
        // fetchInformasi();
      },
    );
  }
}
