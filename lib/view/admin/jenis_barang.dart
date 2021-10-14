import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:service_laptop/component/appbarview.dart';
import 'package:service_laptop/component/boxcontainer.dart';
import 'package:service_laptop/component/list_title.dart';
import 'package:service_laptop/controller/jenis_barang_c.dart';
import 'package:service_laptop/model/jenisbarangmodel.dart';
import 'package:service_laptop/util/colorapp.dart';
import 'package:service_laptop/util/textstyle.dart';
import 'package:service_laptop/view/admin/search_jbarang.dart';
import 'package:sizer/sizer.dart';

class JenisBarangV extends StatelessWidget {
  JenisBarangV({Key key}) : super(key: key);
  final jenisBarangC = Get.put(JenisBarangC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          jenisBarangC.showAdd();
        },
        child: LineIcon.plus(),
      ),
      backgroundColor: ColorApp.canvasColor,
      appBar: AppbarStyle(
        title: Text("JENIS BARANG", style: AppbarTitle()),
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
              showSearch(context: context, delegate: SearchJenisBarang());
            },
            icon: LineIcon.search(
              color: ColorApp.primaryColor,
              size: 7.w,
            ),
          )
        ],
      ),
      body: BoxContainer(
        fields: Obx(() => FutureBuilder(
            future: jenisBarangC.fetchJenisBarang(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: jenisBarangC.jenisBarangList.length ?? 0,
                    itemBuilder: (context, i) {
                      JenisBarang x = jenisBarangC.jenisBarangList[i];
                      return Slidable(
                        actionPane: const SlidableDrawerActionPane(),
                        actions: [
                          IconButton(
                              onPressed: () {
                                jenisBarangC.jenisBarangTxt.text =
                                    x.jenisBarang;
                                jenisBarangC.showEdit(
                                  id: x.id,
                                );
                              },
                              icon: LineIcon.editAlt(
                                  color: Colors.blue, size: 7.w)),
                          IconButton(
                              onPressed: () {
                                jenisBarangC.showDialog(id: x.id);
                              },
                              icon:
                                  LineIcon.trash(color: Colors.red, size: 7.w)),
                        ],
                        child: ListItem(
                          title: x.jenisBarang,
                          subTitle: x.kodeBarang,
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
    );
  }
}
