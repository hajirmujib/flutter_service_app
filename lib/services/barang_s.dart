// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:service_laptop/model/barangmodel.dart';

import 'base_services.dart';
import 'package:http/http.dart' as http;

class BarangS {
  static String url = "http://" + BaseServices().ip + "/service/api";

  // ignore: duplicate_ignore
  Future<List<Barang>> getBarang() async {
    var x;

    final res =
        await http.get(Uri.http(BaseServices().ip, "/service/api/Barang"));
    if (res.statusCode == 200) {
      var response = barangModelFromJson(res.body);
      if (response.status == true) {
        x = response.data;
      } else {
        x = null;
      }
    } else {
      x = null;
    }

    return x;
  }

  Future<Barang> detailBarang({String id}) async {
    var x;
    final res = await http.get(Uri.http(
        BaseServices().ip, "/service/api/Barang/cek", {"serial_number": id}));
    if (res.statusCode == 200) {
      var response = json.decode(res.body);
      if (response['status'] == true) {
        final json = barangModelFromJson(res.body);
        x = json.data[0];
      } else {
        x = null;
      }
    } else {
      x = null;
    }

    return x;
  }

  static Future<List> deleteBarang({String id}) async {
    var x;

    final response = await http.get(
      Uri.http(BaseServices().ip, "/service/api/barang/delete", {
        "id": id,
      }),
    );

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["gagal", "2"];
    }

    return x;
  }

  static Future<List> addBarang(
      {String serialNumber,
      String seri,
      String type,
      String jenisBarang}) async {
    List x;
    var uri = await http
        .post(Uri.http(BaseServices().ip, "/service/api/Barang"), body: {
      "serial_number": serialNumber,
      "seri": seri,
      "type": type,
      "jenis_barang": jenisBarang,
    });
    Map<String, dynamic> res = json.decode(uri.body);

    if (uri.statusCode == 201 && res['status'] == true) {
      x = ["berhasil"];
    } else {
      x = ["Gagal", res['status'], uri.statusCode];
    }
    return x;
  }

  static Future<List> editBarang(
      {String serialNumber,
      String seri,
      String type,
      String jenisBarang,
      String id}) async {
    List x;
    var uri = await http
        .post(Uri.http(BaseServices().ip, "/service/api/Barang/edit"), body: {
      "jenis_barang": jenisBarang,
      "id": id,
      "type": type,
      "seri": seri,
      "serial_number": serialNumber,
    });
    Map<String, dynamic> res = json.decode(uri.body);

    if (uri.statusCode == 201 && res['status'] == true) {
      x = ["berhasil"];
    } else {
      x = ["Gagal", res['status'], uri.statusCode];
    }
    return x;
  }
}
