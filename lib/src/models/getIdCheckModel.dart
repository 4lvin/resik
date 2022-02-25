// To parse this JSON data, do
//
//     final getIdCheckModel = getIdCheckModelFromJson(jsonString);

import 'dart:convert';

class GetIdCheckModel {
  GetIdCheckModel({
    this.status,
    this.data,
    this.message,
  });

  bool? status;
  List<Datum>? data;
  String? message;

  factory GetIdCheckModel.fromRawJson(String str) =>
      GetIdCheckModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetIdCheckModel.fromJson(Map<String, dynamic> json) =>
      GetIdCheckModel(
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
    this.idAnggota,
    this.pin,
  });

  String? idAnggota;
  String? pin;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idAnggota: json["id_anggota"],
        pin: json["pin"],
      );

  Map<String, dynamic> toJson() => {
        "id_anggota": idAnggota,
        "pin": pin,
      };
}
