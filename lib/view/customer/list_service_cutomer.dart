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

class ServiceListCustomer extends StatelessWidget {
  ServiceListCustomer({Key key}) : super(key: key);
  final serviceC = Get.put(ServiceC());
  final chatC = Get.put(ChatC());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: ColorApp.canvasColor,
        appBar: AppBar(
          title: Text(
            "DAFTAR SERVICE",
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
          bottom: TabBar(
              labelColor: ColorApp.primaryColor,
              labelStyle:
                  TextStyle(color: ColorApp.primaryColor, fontSize: 15.sp),
              tabs: const [
                Tab(
                  text: "Belum DiServiced",
                ),
                Tab(
                  text: "Sedang DiServiced",
                ),
              ]),
          // actions: actions,
          backgroundColor: ColorApp.canvasColor,
          elevation: 0.0,
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              BoxContainer(
                fields: Obx(() => FutureBuilder(
                    future: serviceC.fetchServiceCustomerNew(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (serviceC.serviceCustomerNew.isNotEmpty) {
                          return ListView.builder(
                              itemCount:
                                  serviceC.serviceCustomerNew.length ?? 0,
                              itemBuilder: (context, i) {
                                Service x = serviceC.serviceCustomerNew[i];
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
                              });
                        } else {
                          return Center(
                            child:
                                Text("Tidak Ada Data", style: EmailProfile()),
                          );
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    })),
              ),
              BoxContainer(
                fields: Obx(() {
                  return FutureBuilder(
                      future: serviceC.fetchServiceCustomerServiced(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (serviceC.serviceCustomerServiced.isNotEmpty) {
                            return ListView.builder(
                                itemCount:
                                    serviceC.serviceCustomerServiced.length ??
                                        0,
                                itemBuilder: (context, i) {
                                  Service x =
                                      serviceC.serviceCustomerServiced[i];
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
                                });
                          } else {
                            return Center(
                              child:
                                  Text("Tidak Ada Data", style: EmailProfile()),
                            );
                          }
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      });
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
