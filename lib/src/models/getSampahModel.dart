// To parse this JSON data, do
//
//     final getSampahModel = getSampahModelFromJson(jsonString);

import 'dart:convert';

class GetSampahModel {
  GetSampahModel({
    this.status,
    this.data,
    this.message,
  });

  bool? status;
  List<Datum>? data;
  String? message;

  factory GetSampahModel.fromRawJson(String str) =>
      GetSampahModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetSampahModel.fromJson(Map<String, dynamic> json) => GetSampahModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  Datum({
    this.idSampah,
    this.idJenis,
    this.jenisSampah,
    this.namaSampah,
    this.hargaSetor,
    this.hargaJual,
    this.image,
  });

  String? idSampah;
  String? idJenis;
  String? jenisSampah;
  String? namaSampah;
  String? hargaSetor;
  String? hargaJual;
  String? image;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idSampah: json["id_sampah"],
        idJenis: json["id_jenis"],
        jenisSampah: json["jenis_sampah"],
        namaSampah: json["nama_sampah"],
        hargaSetor: json["harga_setor"],
        hargaJual: json["harga_jual"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id_sampah": idSampah,
        "id_jenis": idJenis,
        "jenis_sampah": jenisSampah,
        "nama_sampah": namaSampah,
        "harga_setor": hargaSetor,
        "harga_jual": hargaJual,
        "image": image,
      };
}
