// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:service_laptop/model/jenisbarangmodel.dart';
import 'package:http/http.dart' as http;

import 'base_services.dart';

class JenisBarangS {
  static String url = "http://" + BaseServices().ip + "/service/api";
  Future<List<JenisBarang>> getJenisBarang() async {
    var x;

    final res = await http
        .get(Uri.http(BaseServices().ip, "/service/api/Jenis_barang"));
    if (res.statusCode == 200) {
      var response = jenisBarangModelFromJson(res.body);
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

  static Future<List> addJenisBarang({String jenisBarang}) async {
    List x;
    var uri = await http
        .post(Uri.http(BaseServices().ip, "/service/api/Jenis_barang"), body: {
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

  static Future<List> editJenisBarang({String jenisBarang, String id}) async {
    List x;
    var uri = await http.post(
        Uri.http(BaseServices().ip, "/service/api/Jenis_barang/edit"),
        body: {
          "id": id,
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

  static Future<List> deleteJenisBarang({String id}) async {
    var x;

    final response = await http.get(
      Uri.http(BaseServices().ip, "/service/api/Jenis_barang/delete", {
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
}
