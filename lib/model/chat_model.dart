// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  ChatModel({
    this.status,
    this.data,
  });

  bool status;
  List<Chat> data;

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        status: json["status"],
        data: List<Chat>.from(json["data"].map((x) => Chat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Chat {
  Chat({
    this.nama,
    this.idUser,
    this.foto,
    this.tgl,
    this.idChat,
    this.status,
    this.idService,
    this.text,
    this.type,
    this.file,
  });

  Nama nama;
  String idUser;
  String foto;
  DateTime tgl;
  String idChat;
  Status status;
  String idService;
  String text;
  String type;
  String file;

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        nama: namaValues.map[json["nama"]],
        idUser: json["id_user"],
        foto: json["foto"],
        tgl: DateTime.parse(json["tgl"]),
        idChat: json["id_chat"],
        status: statusValues.map[json["status"]],
        idService: json["id_service"],
        text: json["text"],
        type: json["type"],
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "nama": namaValues.reverse[nama],
        "id_user": idUser,
        "foto": fotoValues.reverse[foto],
        "tgl": tgl.toIso8601String(),
        "id_chat": idChat,
        "status": statusValues.reverse[status],
        "id_service": idService,
        "text": text,
        "type": type,
        "file": file,
      };
}

enum Foto { EMPTY, THE_08092021215754_IMG_20210825_WA0004_JPG }

final fotoValues = EnumValues({
  "": Foto.EMPTY,
  "08092021215754_IMG-20210825-WA0004.jpg":
      Foto.THE_08092021215754_IMG_20210825_WA0004_JPG
});

enum Nama { ADMIN_1, HAJIR }

final namaValues = EnumValues({"Admin 1": Nama.ADMIN_1, "Hajir": Nama.HAJIR});

enum Status { SEEN, STATUS_SEEN }

final statusValues =
    EnumValues({"seen": Status.SEEN, "Seen": Status.STATUS_SEEN});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
