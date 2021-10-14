import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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

class ServiceList extends StatelessWidget {
  ServiceList({Key key}) : super(key: key);
  final serviceC = Get.put(ServiceC());
  final chatC = Get.put(ChatC());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
                  text: "Baru",
                ),
                Tab(
                  text: "Proses",
                ),
                Tab(
                  text: "Selesai",
                )
              ]),
          // actions: actions,
          backgroundColor: ColorApp.canvasColor,
          elevation: 0.0,
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              FutureBuilder(
                future: serviceC.fetchServiceBaru(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (serviceC.serviceNew.isNotEmpty) {
                      return Obx(() => ListView.builder(
                          itemCount: serviceC.serviceNew.length ?? 0,
                          itemBuilder: (context, i) {
                            Service x = serviceC.serviceNew[i];

                            return Slidable(
                              actionPane: const SlidableDrawerActionPane(),
                              actions: [
                                IconButton(
                                    onPressed: () {
                                      serviceC.idService.value = x.idService;
                                      serviceC.showDialog();
                                    },
                                    icon: LineIcon.trash(
                                        color: Colors.red, size: 7.w)),
                              ],
                              child: InkWell(
                                onTap: () {
                                  serviceC.idService.value = x.idService;
                                  chatC.idService.value = x.idService;
                                  Get.to(() => DetailService(),
                                      duration: 0.5.seconds,
                                      transition: Transition.upToDown);
                                },
                                child: ListItem(
                                  title: x.kodeService,
                                  subTitle: x.tglMasuk.toString(),
                                ),
                              ),
                            );
                          }));
                    } else {
                      return Center(
                        child: Text("Tidak Ada Data", style: AppbarTitle()),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              BoxContainer(
                fields: FutureBuilder(
                    future: serviceC.fetchServiceServiced(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? serviceC.serviceServiced.isNotEmpty
                              ? Obx(() => ListView.builder(
                                  itemCount:
                                      serviceC.serviceServiced.length ?? 0,
                                  itemBuilder: (context, i) {
                                    Service x = serviceC.serviceServiced[i];

                                    return Slidable(
                                      actionPane:
                                          const SlidableDrawerActionPane(),
                                      actions: [
                                        IconButton(
                                            onPressed: () {
                                              serviceC.idService.value =
                                                  x.idService;
                                              serviceC.showDialog();
                                            },
                                            icon: LineIcon.trash(
                                                color: Colors.red, size: 7.w)),
                                      ],
                                      child: InkWell(
                                        onTap: () {
                                          serviceC.idService.value =
                                              x.idService;
                                          chatC.idService.value = x.idService;
                                          Get.to(() => DetailService(),
                                              duration: 0.5.seconds,
                                              transition: Transition.upToDown);
                                        },
                                        child: ListItem(
                                          title: x.kodeService,
                                          subTitle: x.tglMasuk.toString(),
                                        ),
                                      ),
                                    );
                                  }))
                              : Center(
                                  child: Text("Tidak Ada Data",
                                      style: AppbarTitle()),
                                )
                          : const Center(
                              child: CircularProgressIndicator(),
                            );
                    }),
              ),
              BoxContainer(
                fields: Obx(() => FutureBuilder(
                    future: serviceC.fetchServiceSelesai(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (serviceC.serviceDone.isNotEmpty) {
                          return Obx(() => ListView.builder(
                              shrinkWrap: true,
                              itemCount: serviceC.serviceDone.length ?? 0,
                              itemBuilder: (context, i) {
                                Service x = serviceC.serviceDone[i];

                                return Slidable(
                                  actionPane: const SlidableDrawerActionPane(),
                                  actions: [
                                    IconButton(
                                        onPressed: () {
                                          serviceC.idService.value =
                                              x.idService;
                                          serviceC.showDialog();
                                        },
                                        icon: LineIcon.trash(
                                            color: Colors.red, size: 7.w)),
                                  ],
                                  child: InkWell(
                                    onTap: () {
                                      serviceC.idService.value = x.idService;
                                      chatC.idService.value = x.idService;
                                      Get.to(() => DetailService(),
                                          duration: 0.5.seconds,
                                          transition: Transition.upToDown);
                                    },
                                    child: ListItem(
                                      title: x.kodeService,
                                      subTitle: x.tglMasuk.toString(),
                                    ),
                                  ),
                                );
                              }));
                        } else {
                          return Center(
                            child: Text("Tidak Ada Data", style: AppbarTitle()),
                          );
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    })),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
