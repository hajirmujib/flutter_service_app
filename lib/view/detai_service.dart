import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:service_laptop/component/appbarview.dart';
import 'package:service_laptop/component/boxcontainer.dart';
import 'package:service_laptop/controller/login_c.dart';
import 'package:service_laptop/controller/service_c.dart';
import 'package:service_laptop/services/base_services.dart';
import 'package:service_laptop/util/colorapp.dart';
import 'package:service_laptop/util/textstyle.dart';
import 'package:service_laptop/view/admin/edit_service.dart';
import 'package:service_laptop/view/chat_view.dart';
import 'package:sizer/sizer.dart';

class DetailService extends StatelessWidget {
  DetailService({Key key}) : super(key: key);

  final serviceC = Get.put(ServiceC());
  final loginC = Get.put(LoginC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => ChatView(),
              duration: 0.5.seconds, transition: Transition.downToUp);
        },
        child: LineIcon.facebookMessenger(
          size: 10.w,
        ),
      ),
      backgroundColor: ColorApp.canvasColor,
      appBar: AppbarStyle(
        title: Column(
          children: [
            Text(
              "DETAIL SERVICE",
              style: AppbarTitle(),
            ),
            Text(
              serviceC.serviceById().kodeService,
              style: EmailProfile(),
            )
          ],
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: LineIcon.arrowLeft(
            color: ColorApp.primaryColor,
            size: 7.w,
          ),
        ),
        actions: [
          loginC.level.value != "Customer"
              ? IconButton(
                  onPressed: () {
                    Get.to(() => EditService(),
                        duration: 0.5.seconds, transition: Transition.upToDown);
                    serviceC.kendala.text = serviceC.serviceById().kendala;
                    serviceC.kelengkapan.text =
                        serviceC.serviceById().kelengkapan;
                    serviceC.kerusakan.text = serviceC.serviceById().kerusakan;
                    serviceC.biaya.text = serviceC.serviceById().biaya;
                    serviceC.foto1Txt.value = serviceC.serviceById().foto1;
                    serviceC.foto2Txt.value = serviceC.serviceById().foto2;
                    serviceC.foto3Txt.value = serviceC.serviceById().foto3;
                    serviceC.idUser.text = serviceC.serviceById().idUser;
                    serviceC.kodeService.value =
                        serviceC.serviceById().kodeService;
                    serviceC.tglMasuk.value =
                        serviceC.serviceById().tglMasuk.toString();
                    serviceC.tglKeluar.value =
                        serviceC.serviceById().tglKeluar.toString();
                    serviceC.status.text = serviceC.serviceById().status;
                    // serviceC.idService.value = serviceC.serviceById().idService;
                    serviceC.serialNumber.text =
                        serviceC.serviceById().serialNumber;
                  },
                  icon: LineIcon.editAlt(
                    color: ColorApp.primaryColor,
                  ))
              : const Text(""),
        ],
      ),
      body: BoxContainer(
        fields: Obx(() => FutureBuilder(
            future: serviceC.servicedetail(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Serial Number",
                            style: NameStyle(),
                          )),
                          Obx(() => Expanded(
                              child: Text(
                                  ": " + serviceC.serviceById().serialNumber,
                                  style: EmailProfile()))),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Tgl. Masuk",
                            style: NameStyle(),
                          )),
                          Expanded(
                              child: Obx(() => Text(
                                  ": " + serviceC.serviceById().tglMasuk,
                                  style: EmailProfile()))),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Kendala",
                            style: NameStyle(),
                          )),
                          Expanded(
                              child: Obx(() => Text(
                                  ": " + serviceC.serviceById().kendala,
                                  style: EmailProfile()))),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Kerusakan",
                            style: NameStyle(),
                          )),
                          Expanded(
                              child: Obx(() => Text(
                                  ": " + serviceC.serviceById().kerusakan,
                                  style: EmailProfile()))),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Kelengkapan",
                            style: NameStyle(),
                          )),
                          Expanded(
                              child: Obx(() => Text(
                                  ": " + serviceC.serviceById().kelengkapan,
                                  style: EmailProfile()))),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Status",
                            style: NameStyle(),
                          )),
                          Expanded(
                              child: Obx(() => Text(
                                  ": " + serviceC.serviceById().status,
                                  style: EmailProfile()))),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Tgl. Keluar",
                            style: NameStyle(),
                          )),
                          Expanded(
                              child: Obx(() => Text(
                                  ": " + serviceC.serviceById().tglKeluar,
                                  style: EmailProfile()))),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Biaya",
                            style: NameStyle(),
                          )),
                          Expanded(
                              child: Obx(() => Text(
                                  ": Rp." + serviceC.serviceById().biaya,
                                  style: EmailProfile()))),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Pelanggan",
                            style: NameStyle(),
                          )),
                          Expanded(
                              child: Obx(() => Text(
                                  ": " +
                                              serviceC
                                                  .serviceById()
                                                  .nama
                                                  .toString() ==
                                          null
                                      ? "User Terhapus"
                                      : serviceC.serviceById().nama.toString(),
                                  style: EmailProfile()))),
                          // Expanded(
                          //     child:
                          //         Text(": Nama User", style: EmailProfile())),
                        ],
                      ),
                      Text("Foto", style: NameStyle()),
                      Obx(() => Row(
                            children: [
                              serviceC.serviceById().foto1 != ""
                                  ? Padding(
                                      padding: EdgeInsets.all(2.w),
                                      child: Image.network(
                                        BaseServices().urlFile +
                                            "/service/kelengkapan/" +
                                            serviceC.serviceById().foto1,
                                        width: 20.w,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const Text(""),
                              serviceC.serviceById().foto2 != ""
                                  ? Padding(
                                      padding: EdgeInsets.all(2.w),
                                      child: Image.network(
                                        BaseServices().urlFile +
                                            "/service/kelengkapan/" +
                                            serviceC.serviceById().foto2,
                                        width: 20.w,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const Text(""),
                              serviceC.serviceById().foto3 != ""
                                  ? Padding(
                                      padding: EdgeInsets.all(2.w),
                                      child: Image.network(
                                        BaseServices().urlFile +
                                            "/service/kelengkapan/" +
                                            serviceC.serviceById().foto3,
                                        width: 20.w,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const Text(""),
                            ],
                          ))
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            })),
      ),
    );
  }
}
