// To parse this JSON data, do
//
//     final jenisBarangModel = jenisBarangModelFromJson(jsonString);

import 'dart:convert';

JenisBarangModel jenisBarangModelFromJson(String str) =>
    JenisBarangModel.fromJson(json.decode(str));

String jenisBarangModelToJson(JenisBarangModel data) =>
    json.encode(data.toJson());

class JenisBarangModel {
  JenisBarangModel({
    this.status,
    this.data,
  });

  bool status;
  List<JenisBarang> data;

  factory JenisBarangModel.fromJson(Map<String, dynamic> json) =>
      JenisBarangModel(
        status: json["status"],
        data: List<JenisBarang>.from(
            json["data"].map((x) => JenisBarang.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class JenisBarang {
  JenisBarang({
    this.id,
    this.kodeBarang,
    this.jenisBarang,
  });

  String id;
  String kodeBarang;
  String jenisBarang;

  factory JenisBarang.fromJson(Map<String, dynamic> json) => JenisBarang(
        id: json["id"],
        kodeBarang: json["kode_barang"],
        jenisBarang: json["jenis_barang"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode_barang": kodeBarang,
        "jenis_barang": jenisBarang,
      };
}
