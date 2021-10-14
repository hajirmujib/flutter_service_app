import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:service_laptop/component/appbarview.dart';
import 'package:service_laptop/component/boxcontainer.dart';
import 'package:service_laptop/component/list_title.dart';
import 'package:service_laptop/controller/chat_c.dart';
import 'package:service_laptop/controller/service_c.dart';
import 'package:service_laptop/model/servicemodel.dart';
import 'package:service_laptop/util/colorapp.dart';
import 'package:service_laptop/util/textstyle.dart';
import 'package:service_laptop/view/detai_service.dart';
import 'package:sizer/sizer.dart';

class ServiceListTeknisi extends StatelessWidget {
  ServiceListTeknisi({Key key}) : super(key: key);
  final serviceC = Get.put(ServiceC());
  final chatC = Get.put(ChatC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Get.to(() => AddUser(),
      //         duration: 0.5.seconds, transition: Transition.upToDown);
      //   },
      //   child: LineIcon.search(),
      // ),
      backgroundColor: ColorApp.canvasColor,
      appBar: AppbarStyle(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("DAFTAR SERVICE", style: AppbarTitle()),
            Text(serviceC.statusTemp.value, style: EmailProfile()),
          ],
        ),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: LineIcon.arrowLeft(
              color: ColorApp.primaryColor,
              size: 7.w,
            )),
      ),
      body: BoxContainer(
        fields: Obx(() => FutureBuilder(
            future: serviceC.fetchServiceTeknisi(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (serviceC.serviceList.isNotEmpty) {
                  return Obx(() => ListView.builder(
                      itemCount: serviceC.serviceList.length ?? 0,
                      itemBuilder: (context, i) {
                        Service x = serviceC.serviceList[i];

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
                    child: Text("Data Tidak Ada", style: EmailProfile()),
                  );
                }
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
