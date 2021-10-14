// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:service_laptop/model/users_model.dart';
import 'dart:async';

import 'base_services.dart';

class UserServices {
  static String url = "http://" + BaseServices().ip + "/service/api";

  Future<List<Users>> getUser() async {
    var x;

    final res =
        await http.get(Uri.http(BaseServices().ip, "/service/api/User"));
    if (res.statusCode == 200) {
      var response = usersModelFromJson(res.body);
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

  Future<Users> detailUser({String email}) async {
    var x;
    final res = await http.get(
        Uri.http(BaseServices().ip, "/service/api/User/cek", {"email": email}));
    if (res.statusCode == 201) {
      var response = json.decode(res.body);
      if (response['status'] == true) {
        final json = usersModelFromJson(res.body);
        x = json.data[0];
      } else {
        x = null;
      }
    } else {
      x = null;
    }

    return x;
  }

  Future<List<Users>> getCustomer() async {
    var x;

    final res = await http
        .get(Uri.http(BaseServices().ip, "/service/api/User/customer"));
    if (res.statusCode == 200) {
      var response = usersModelFromJson(res.body);
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

  Future<Users> getUserById({String id}) async {
    var x;

    final res =
        await http.get(Uri.http(BaseServices().ip, "/service/api/user", {
      "id_user": id,
    }));
    if (res.statusCode == 200) {
      var response = usersModelFromJson(res.body);
      var decode = json.decode(res.body);
      if (response.status == true) {
        x = Users.fromJson(decode['data'][0]);
      } else {
        x = null;
      }
    } else {
      x = null;
    }

    return x;
  }

  static Future<List> deleteUser({String id}) async {
    var x;

    final response = await http.get(
      Uri.http(BaseServices().ip, "/service/api/User/delete", {
        "id_user": id,
      }),
    );

    if (response.statusCode == 201) {
      x = ["berhasil", response.statusCode];
    } else {
      x = ["gagal", response.statusCode];
    }

    return x;
  }

  static Future<List> addUser(
      {String nama,
      String noTelp,
      String email,
      String password,
      String level,
      File foto}) async {
    List x;
    var uri = Uri.parse(url + "/User");
    http.MultipartRequest request = http.MultipartRequest("POST", uri);

    if (foto.path != "") {
      var streamImage = http.ByteStream(StreamView(foto.openRead()));
      var lengthImage = await foto.length();

      request.files.add(http.MultipartFile('foto', streamImage, lengthImage,
          filename: path.basename(foto.path)));
    }

    request.fields['nama'] = nama ?? "";
    request.fields['no_telp'] = noTelp ?? "";
    request.fields['email'] = email ?? "";
    request.fields['password'] = password ?? "";
    request.fields['level'] = level ?? "";

    var response = await request.send();
    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["Gagal"];
    }
    return x;
  }

  static Future<List> editUser(
      {String nama,
      String noTelp,
      String email,
      String password,
      String level,
      String idUser,
      File foto}) async {
    List x;
    var uri = Uri.parse(url + "/User/Edit");
    http.MultipartRequest request = http.MultipartRequest("POST", uri);

    if (foto.path != "") {
      var streamImage = http.ByteStream(StreamView(foto.openRead()));
      var lengthImage = await foto.length();

      request.files.add(http.MultipartFile('foto', streamImage, lengthImage,
          filename: path.basename(foto.path)));
    }

    request.fields['nama'] = nama ?? "";
    request.fields['no_telp'] = noTelp ?? "";
    request.fields['email'] = email ?? "";
    request.fields['password'] = password ?? "";

    request.fields['level'] = level ?? "";
    request.fields['id_user'] = idUser ?? "";

    var response = await request.send();

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["Gagal", response.statusCode];
    }
    return x;
  }
}
