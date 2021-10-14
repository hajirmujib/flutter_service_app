import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:service_laptop/component/appbarview.dart';
import 'package:service_laptop/component/boxcontainer.dart';
import 'package:service_laptop/component/list_title.dart';
import 'package:service_laptop/controller/barang_c.dart';
import 'package:service_laptop/model/barangmodel.dart';
import 'package:service_laptop/util/colorapp.dart';
import 'package:service_laptop/util/textstyle.dart';
import 'package:service_laptop/view/admin/detail_barang.dart';
import 'package:service_laptop/view/admin/search_barang.dart';
import 'package:sizer/sizer.dart';

import 'add_barang.dart';

class BarangV extends StatelessWidget {
  BarangV({Key key}) : super(key: key);
  final barangC = Get.put(BarangC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddBarang());
        },
        child: LineIcon.plus(),
      ),
      backgroundColor: ColorApp.canvasColor,
      appBar: AppbarStyle(
        title: Text("DAFTAR BARANG", style: AppbarTitle()),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: LineIcon.arrowLeft(
              color: ColorApp.primaryColor,
              size: 7.w,
            )),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchBarang());
            },
            icon: LineIcon.search(
              color: ColorApp.primaryColor,
              size: 7.w,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: BoxContainer(
          fields: Obx(() => FutureBuilder(
              future: barangC.fetchBarang(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: barangC.barangList.length ?? 0,
                      itemBuilder: (context, i) {
                        Barang x = barangC.barangList[i];
                        return Slidable(
                          actionPane: const SlidableDrawerActionPane(),
                          actions: [
                            IconButton(
                                onPressed: () {
                                  barangC.showDialog(id: x.id);
                                },
                                icon: LineIcon.trash(
                                    color: Colors.red, size: 7.w)),
                          ],
                          child: InkWell(
                            onTap: () {
                              barangC.idBarang.value = x.id;
                              Get.to(() => DetailBarang(),
                                  transition: Transition.upToDown,
                                  duration: 0.5.seconds);
                            },
                            child: ListItem(
                              title: x.serialNumber,
                              subTitle: x.jenisBarang,
                            ),
                          ),
                        );
                      });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
        ),
      ),
    );
  }
}
