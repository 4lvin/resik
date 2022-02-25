// To parse this JSON data, do
//
//     final getHistoryModel = getHistoryModelFromJson(jsonString);

import 'dart:convert';

class GetHistoryModel {
  GetHistoryModel({
    this.status,
    this.data,
    this.message,
  });

  bool? status;
  List<Datum>? data;
  String? message;

  factory GetHistoryModel.fromRawJson(String str) =>
      GetHistoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetHistoryModel.fromJson(Map<String, dynamic> json) =>
      GetHistoryModel(
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
    this.id,
    this.tanggal,
    this.keterangan,
    this.harga,
    this.kode,
    this.tipe,
    this.status,
  });

  String? id;
  DateTime? tanggal;
  String? keterangan;
  String? harga;
  String? kode;
  String? tipe;
  String? status;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        tanggal: DateTime.parse(json["tanggal"]),
        keterangan: json["keterangan"],
        harga: json["harga"],
        kode: json["kode"],
        tipe: json["tipe"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tanggal":
            "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        "keterangan": keterangan,
        "harga": harga,
        "kode": kode,
        "tipe": tipe,
        "status": status,
      };
}
