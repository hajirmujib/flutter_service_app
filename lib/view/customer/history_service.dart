import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:service_laptop/component/boxcontainer.dart';
import 'package:service_laptop/component/list_title.dart';
import 'package:service_laptop/controller/chat_c.dart';
import 'package:service_laptop/controller/service_c.dart';
import 'package:service_laptop/model/servicemodel.dart';
import 'package:service_laptop/util/colorapp.dart';
import 'package:service_laptop/util/textstyle.dart';
import 'package:service_laptop/view/detai_service.dart';
import 'package:sizer/sizer.dart';

class HistoryServiceCustomer extends StatelessWidget {
  HistoryServiceCustomer({Key key}) : super(key: key);
  final serviceC = Get.put(ServiceC());
  final chatC = Get.put(ChatC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.canvasColor,
      appBar: AppBar(
        title: Text(
          "RIWAYAT SERVICE",
          style: AppbarTitle(),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: LineIcon.arrowLeft(
            color: ColorApp.primaryColor,
            size: 7.w,
          ),
        ),

        // actions: actions,
        backgroundColor: ColorApp.canvasColor,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: BoxContainer(
          fields: Obx(() {
            return FutureBuilder(
                future: serviceC.fetchServiceCustomerDone(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? serviceC.serviceCustomerDone.isNotEmpty
                          ? ListView.builder(
                              itemCount:
                                  serviceC.serviceCustomerDone.length ?? 0,
                              itemBuilder: (context, i) {
                                Service x = serviceC.serviceCustomerDone[i];
                                return InkWell(
                                  onTap: () {
                                    serviceC.idService.value = x.idService;
                                    chatC.idService.value = x.idService;
                                    Get.to(() => DetailService(),
                                        duration: 0.5.seconds,
                                        transition: Transition.upToDown);
                                  },
                                  child: ListItem(
                                    title: x.serialNumber,
                                    subTitle: x.tglMasuk.toString(),
                                  ),
                                );
                              })
                          : Center(
                              child:
                                  Text("Tidak Ada Data", style: EmailProfile()),
                            )
                      : const Center(child: CircularProgressIndicator());
                });
          }),
        ),
      ),
    );
  }
}
