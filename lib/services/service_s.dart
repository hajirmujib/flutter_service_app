// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:service_laptop/model/servicemodel.dart';
import 'dart:async';
import 'base_services.dart';

class ServiceS {
  static String url = "http://" + BaseServices().ip + "/service/api";

  static Future<List<Service>> getService() async {
    var x;

    final res =
        await http.get(Uri.http(BaseServices().ip, "/service/api/Service"));
    if (res.statusCode == 200) {
      var response = serviceModelFromJson(res.body);
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

  static Future<List<Service>> getSericeCustomer(
      {String idU, String status}) async {
    var x;

    final res = await http.get(Uri.http(BaseServices().ip,
        "/service/api/Service", {"id_user": idU, "status": status}));
    if (res.statusCode == 200) {
      var response = serviceModelFromJson(res.body);
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

  static Future<List<Service>> getSericeStatus({String status}) async {
    var x;

    final res = await http.get(Uri.http(
        BaseServices().ip, "/service/api/Service", {"status": status}));
    if (res.statusCode == 200) {
      var response = serviceModelFromJson(res.body);
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

  Future<Service> getServiceById({String id}) async {
    var x;

    final res =
        await http.get(Uri.http(BaseServices().ip, "/service/api/Service", {
      "id_service": id,
    }));
    if (res.statusCode == 200) {
      var response = serviceModelFromJson(res.body);
      var decode = json.decode(res.body);
      if (response.status == true) {
        x = Service.fromJson(decode['data'][0]);
      } else {
        x = null;
      }
    } else {
      x = null;
    }

    return x;
  }

  static Future<List> deleteService({String id}) async {
    var x;
    final Map<String, dynamic> data = {
      "id_service": id,
    };

    final response = await http.post(
        Uri.http(BaseServices().ip, "/service/api/Service/delete"),
        body: data);

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["gagal", "2"];
    }

    return x;
  }

  static Future<List> addService(
      {String serialNumber,
      String kendala,
      String kerusakan,
      String kelengkapan,
      String idUser,
      XFile foto1,
      XFile foto2,
      XFile foto3}) async {
    List x;
    var uri = Uri.parse(url + "/Service");
    http.MultipartRequest request = http.MultipartRequest("POST", uri);

    if (foto1.path != "") {
      var streamImage = http.ByteStream(StreamView(foto1.openRead()));
      var lengthImage = await foto1.length();

      request.files.add(http.MultipartFile('foto1', streamImage, lengthImage,
          filename: path.basename(foto1.path)));
    }
    if (foto2.path != "") {
      var streamImage = http.ByteStream(StreamView(foto2.openRead()));
      var lengthImage = await foto2.length();

      request.files.add(http.MultipartFile('foto2', streamImage, lengthImage,
          filename: path.basename(foto2.path)));
    }
    if (foto3.path != "") {
      var streamImage = http.ByteStream(StreamView(foto3.openRead()));
      var lengthImage = await foto3.length();

      request.files.add(http.MultipartFile('foto3', streamImage, lengthImage,
          filename: path.basename(foto3.path)));
    }

    request.fields['serial_number'] = serialNumber ?? "";
    request.fields['kendala'] = kendala ?? "";
    request.fields['kerusakan'] = kerusakan ?? "";
    request.fields['kelengkapan'] = kelengkapan ?? "";
    request.fields['id_user'] = idUser ?? "";

    var response = await request.send();

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["Gagal"];
    }
    return x;
  }

  static Future<List> editService(
      {String idService,
      String kodeService,
      String serialNumber,
      String kendala,
      String kerusakan,
      String kelengkapan,
      String biaya,
      String idUser,
      String tglMasuk,
      String tglKeluar,
      XFile foto1,
      XFile foto2,
      XFile foto3,
      String status}) async {
    List x;
    var uri = Uri.parse(url + "/Service/edit");
    http.MultipartRequest request = http.MultipartRequest("POST", uri);

    if (foto1.path != "") {
      var streamImage = http.ByteStream(StreamView(foto1.openRead()));
      var lengthImage = await foto1.length();

      request.files.add(http.MultipartFile('foto1', streamImage, lengthImage,
          filename: path.basename(foto1.path)));
    }
    if (foto2.path != "") {
      var streamImage = http.ByteStream(StreamView(foto2.openRead()));
      var lengthImage = await foto2.length();

      request.files.add(http.MultipartFile('foto2', streamImage, lengthImage,
          filename: path.basename(foto2.path)));
    }
    if (foto3.path != "") {
      var streamImage = http.ByteStream(StreamView(foto3.openRead()));
      var lengthImage = await foto3.length();

      request.files.add(http.MultipartFile('foto3', streamImage, lengthImage,
          filename: path.basename(foto3.path)));
    }

    request.fields['serial_number'] = serialNumber ?? "";
    request.fields['kode_service'] = kodeService ?? "";
    request.fields['kendala'] = kendala ?? "";
    request.fields['kerusakan'] = kerusakan ?? "";
    request.fields['kelengkapan'] = kelengkapan ?? "";
    request.fields['id_user'] = idUser ?? "";
    request.fields['id_service'] = idService ?? "";
    request.fields['tgl_masuk'] = tglMasuk ?? "";
    request.fields['tgl_keluar'] = tglKeluar ?? "";
    request.fields['biaya'] = biaya ?? "";
    request.fields['status'] = status ?? "";

    var response = await request.send();

    if (response.statusCode == 201) {
      x = ["berhasil", response.statusCode];
    } else {
      x = ["Gagal", response.statusCode];
    }
    return x;
  }
}
