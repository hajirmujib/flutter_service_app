// To parse this JSON data, do
//
//     final serviceModel = serviceModelFromJson(jsonString);

import 'dart:convert';

ServiceModel serviceModelFromJson(String str) =>
    ServiceModel.fromJson(json.decode(str));

String serviceModelToJson(ServiceModel data) => json.encode(data.toJson());

class ServiceModel {
  ServiceModel({
    this.status,
    this.data,
  });

  bool status;
  List<Service> data;

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        status: json["status"],
        data: List<Service>.from(json["data"].map((x) => Service.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Service {
  Service({
    this.idService,
    this.kodeService,
    this.serialNumber,
    this.idUser,
    this.kendala,
    this.kerusakan,
    this.tglMasuk,
    this.tglKeluar,
    this.kelengkapan,
    this.foto1,
    this.foto2,
    this.foto3,
    this.status,
    this.biaya,
    this.nama,
    this.seri,
    this.type,
  });

  String idService;
  String kodeService;
  String serialNumber;
  String idUser;
  String kendala;
  String kerusakan;
  String tglMasuk;
  String tglKeluar;
  String kelengkapan;
  String foto1;
  String foto2;
  String foto3;
  String status;
  String biaya;
  String nama;
  String seri;
  String type;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        idService: json["id_service"],
        kodeService: json["kode_service"],
        serialNumber: json["serial_number"],
        idUser: json["id_user"],
        kendala: json["kendala"],
        kerusakan: json["kerusakan"],
        tglMasuk: json["tgl_masuk"],
        tglKeluar: json["tgl_keluar"],
        kelengkapan: json["kelengkapan"],
        foto1: json["foto1"],
        foto2: json["foto2"],
        foto3: json["foto3"],
        status: json["status"],
        biaya: json["biaya"],
        nama: json["nama"],
        seri: json["seri"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id_service": idService,
        "kode_service": kodeService,
        "serial_number": serialNumber,
        "id_user": idUser,
        "kendala": kendala,
        "kerusakan": kerusakan,
        "tgl_masuk": tglMasuk,
        "tgl_keluar": tglKeluar,
        "kelengkapan": kelengkapan,
        "foto1": foto1,
        "foto2": foto2,
        "foto3": foto3,
        "status": status,
        "biaya": biaya,
        "nama": nama,
        "seri": seri,
        "type": type,
      };
}
