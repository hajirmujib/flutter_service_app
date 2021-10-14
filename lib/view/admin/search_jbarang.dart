import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:service_laptop/component/boxcontainer.dart';
import 'package:service_laptop/component/list_title.dart';
import 'package:service_laptop/controller/jenis_barang_c.dart';
import 'package:sizer/sizer.dart';

class SearchJenisBarang extends SearchDelegate<String> {
  final jenisBarangC = Get.find<JenisBarangC>();
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
  String get searchFieldLabel => 'Kode Barang / Barang';
  @override
  Widget buildResults(BuildContext context) {
    final suggestion = jenisBarangC.jenisBarangList.where((name) {
      return name.kodeBarang.toLowerCase().contains(query.toLowerCase()) ||
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
                      jenisBarangC.jenisBarangTxt.text = x.jenisBarang;
                      jenisBarangC.showEdit(
                        id: x.id,
                      );
                    },
                    icon: LineIcon.editAlt(color: Colors.blue, size: 7.w)),
                IconButton(
                    onPressed: () {
                      jenisBarangC.showDialog(id: x.id);
                    },
                    icon: LineIcon.trash(color: Colors.red, size: 7.w)),
              ],
              child: ListItem(
                title: x.jenisBarang,
                subTitle: x.kodeBarang,
              ),
            );
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestion = jenisBarangC.jenisBarangList.where((name) {
      return name.kodeBarang.toLowerCase().contains(query.toLowerCase()) ||
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
                        jenisBarangC.jenisBarangTxt.text = x.jenisBarang;
                        jenisBarangC.showEdit(
                          id: x.id,
                        );
                      },
                      icon: LineIcon.editAlt(color: Colors.blue, size: 7.w)),
                  IconButton(
                      onPressed: () {
                        jenisBarangC.showDialog(id: x.id);
                      },
                      icon: LineIcon.trash(color: Colors.red, size: 7.w)),
                ],
                child: ListItem(
                  title: x.jenisBarang,
                  subTitle: x.kodeBarang,
                ),
              );
            }));
  }
}
