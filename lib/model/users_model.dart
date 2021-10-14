// To parse this JSON data, do
//
//     final usersModel = usersModelFromJson(jsonString);

import 'dart:convert';

UsersModel usersModelFromJson(String str) =>
    UsersModel.fromJson(json.decode(str));

String usersModelToJson(UsersModel data) => json.encode(data.toJson());

class UsersModel {
  UsersModel({
    this.status,
    this.data,
  });

  bool status;
  List<Users> data;

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        status: json["status"],
        data: List<Users>.from(json["data"].map((x) => Users.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Users {
  Users({
    this.idUser,
    this.nama,
    this.foto,
    this.email,
    this.password,
    this.noTelp,
    this.level,
  });

  String idUser;
  String nama;
  String foto;
  String email;
  String password;
  String noTelp;
  String level;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        idUser: json["id_user"],
        nama: json["nama"],
        foto: json["foto"],
        email: json["email"],
        password: json["password"],
        noTelp: json["no_telp"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "nama": nama,
        "foto": foto,
        "email": email,
        "password": password,
        "no_telp": noTelp,
        "level": level,
      };
}
