// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:service_laptop/model/barangmodel.dart';
import 'package:service_laptop/model/chat_model.dart';

import 'base_services.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class ChatS {
  static String url = "http://" + BaseServices().ip + "/service/api";

  // ignore: duplicate_ignore
  Future<List<Chat>> getChat({String idService}) async {
    var x;

    final res = await http.get(Uri.http(
        BaseServices().ip, "/service/api/Chat", {"id_service": idService}));
    if (res.statusCode == 200) {
      var response = chatModelFromJson(res.body);
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

  static Future<List> deleteChat({String id}) async {
    var x;

    final response = await http.get(
      Uri.http(BaseServices().ip, "/service/api/chat/delete", {
        "id_chat": id,
      }),
    );

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["gagal", response.statusCode];
    }

    return x;
  }

  static Future<List> addChat({
    String idService,
    String text,
    String type,
    String idUser,
    String status,
    File file,
  }) async {
    List x;
    var uri = Uri.parse(url + "/Chat");
    http.MultipartRequest request = http.MultipartRequest("POST", uri);

    if (file.path != "") {
      var streamImage = http.ByteStream(StreamView(file.openRead()));
      var lengthImage = await file.length();

      request.files.add(http.MultipartFile('file', streamImage, lengthImage,
          filename: path.basename(file.path)));
    }
    //  else if (image.path != "" && type == "Image") {
    //   var streamImage = http.ByteStream(StreamView(file.openRead()));
    //   var lengthImage = await file.length();

    //   request.files.add(http.MultipartFile('file', streamImage, lengthImage,
    //       filename: path.basename(file.path)));
    // }

    request.fields['id_service'] = idService ?? "";
    request.fields['text'] = text ?? "";
    request.fields['id_user'] = idUser ?? "";
    request.fields['status'] = status ?? "";
    request.fields['type'] = type ?? "";

    var response = await request.send();

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["Gagal"];
    }
    return x;
  }

  static Future<List> editChat(
      {String idChat,
      String idService,
      String text,
      String type,
      String idUser,
      String status,
      File file}) async {
    List x;
    var uri = Uri.parse(url + "/Chat/edit");
    http.MultipartRequest request = http.MultipartRequest("POST", uri);

    if (file.path != "") {
      var streamImage = http.ByteStream(StreamView(file.openRead()));
      var lengthImage = await file.length();

      request.files.add(http.MultipartFile('file', streamImage, lengthImage,
          filename: path.basename(file.path)));
    }

    request.fields['id_service'] = idService ?? "";
    request.fields['text'] = text ?? "";
    request.fields['id_user'] = idUser ?? "";
    request.fields['status'] = status ?? "";
    request.fields['type'] = type ?? "";
    request.fields['id_chat'] = idChat ?? "";

    var response = await request.send();

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["Gagal"];
    }
    return x;
  }
}
