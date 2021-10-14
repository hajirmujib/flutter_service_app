// To parse this JSON data, do
//
//     final barangModel = barangModelFromJson(jsonString);

import 'dart:convert';

BarangModel barangModelFromJson(String str) =>
    BarangModel.fromJson(json.decode(str));

String barangModelToJson(BarangModel data) => json.encode(data.toJson());

class BarangModel {
  BarangModel({
    this.status,
    this.data,
  });

  bool status;
  List<Barang> data;

  factory BarangModel.fromJson(Map<String, dynamic> json) => BarangModel(
        status: json["status"],
        data: List<Barang>.from(json["data"].map((x) => Barang.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Barang {
  Barang({
    this.id,
    this.serialNumber,
    this.seri,
    this.type,
    this.jenisBarang,
    this.kodeBarang,
  });

  String id;
  String serialNumber;
  String seri;
  String type;
  String jenisBarang;
  String kodeBarang;

  factory Barang.fromJson(Map<String, dynamic> json) => Barang(
        id: json["id"],
        serialNumber: json["serial_number"],
        seri: json["seri"],
        type: json["type"],
        jenisBarang: json["namaBarang"],
        kodeBarang: json["jenis_barang"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "serial_number": serialNumber,
        "seri": seri,
        "type": type,
        "namaBarang": jenisBarang,
        "jenis_barang": kodeBarang,
      };
}
