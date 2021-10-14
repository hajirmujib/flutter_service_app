import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:service_laptop/component/boxcontainer.dart';
import 'package:service_laptop/component/list_title.dart';
import 'package:service_laptop/controller/barang_c.dart';
import 'package:sizer/sizer.dart';

import 'detail_barang.dart';

class SearchBarang extends SearchDelegate<String> {
  final barangC = Get.find<BarangC>();
  final String result = "";
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, result);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  String get searchFieldLabel => 'Serial Number / Barang';
  @override
  Widget buildResults(BuildContext context) {
    final suggestion = barangC.barangList.where((name) {
      return name.serialNumber.toLowerCase().contains(query.toLowerCase()) ||
          name.jenisBarang.toLowerCase().contains(query.toLowerCase());
    });
    return BoxContainer(
      fields: ListView.builder(
          itemCount: suggestion.length ?? 0,
          itemBuilder: (context, i) {
            var x = suggestion.elementAt(i);
            return Slidable(
              actionPane: const SlidableDrawerActionPane(),
              actions: [
                IconButton(
                    onPressed: () {
                      barangC.showDialog(id: x.id);
                    },
                    icon: LineIcon.trash(color: Colors.red, size: 7.w)),
              ],
              child: InkWell(
                onTap: () {
                  barangC.idBarang.value = x.id;
                  Get.to(() => DetailBarang(),
                      transition: Transition.upToDown, duration: 0.5.seconds);
                },
                child: ListItem(
                  title: x.serialNumber,
                  subTitle: x.jenisBarang,
                ),
              ),
            );
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestion = barangC.barangList.where((name) {
      return name.serialNumber.toLowerCase().contains(query.toLowerCase()) ||
          name.jenisBarang.toLowerCase().contains(query.toLowerCase());
    });
    return BoxContainer(
        fields: ListView.builder(
            itemCount: suggestion.length ?? 0,
            itemBuilder: (context, i) {
              var x = suggestion.elementAt(i);
              return Slidable(
                actionPane: const SlidableDrawerActionPane(),
                actions: [
                  IconButton(
                      onPressed: () {
                        barangC.showDialog(id: x.id);
                      },
                      icon: LineIcon.trash(color: Colors.red, size: 7.w)),
                ],
                child: InkWell(
                  onTap: () {
                    barangC.idBarang.value = x.id;
                    Get.to(() => DetailBarang(),
                        transition: Transition.upToDown, duration: 0.5.seconds);
                  },
                  child: ListItem(
                    title: x.serialNumber,
                    subTitle: x.jenisBarang,
                  ),
                ),
              );
            }));
  }
}
