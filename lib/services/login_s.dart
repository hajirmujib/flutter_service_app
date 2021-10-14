import 'dart:convert';
import 'package:service_laptop/model/users_model.dart';

import 'package:http/http.dart' as http;

import 'base_services.dart';

class LoginS {
  static String url = "http://" + BaseServices().ip + "/service/api";

  static Future<List> login({String email, String password}) async {
    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password
    };
    var result = [];

    final response = await http.post(
        Uri.http(BaseServices().ip, "/service/api/Auth/login"),
        body: loginData);

    final Map<String, dynamic> resUser = json.decode(response.body);

    if (resUser['status'] == true) {
      final resData = usersModelFromJson(response.body);
      final List<Users> user = resData.data;
      result = [
        "login",
        user[0].idUser,
        user[0].level,
      ];
    } else {
      result = [
        "not loggin",
        "Password / Email Salah",
        null,
        resUser['status']
      ];
    }
    return result;
  }
}
