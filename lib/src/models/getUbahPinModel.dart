// To parse this JSON data, do
//
//     final getUbahPinModel = getUbahPinModelFromJson(jsonString);

import 'dart:convert';

class GetUbahPinModel {
  GetUbahPinModel({
    this.status,
    this.data,
    this.message,
  });

  bool? status;
  Data? data;
  String? message;

  factory GetUbahPinModel.fromRawJson(String str) =>
      GetUbahPinModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetUbahPinModel.fromJson(Map<String, dynamic> json) =>
      GetUbahPinModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    this.idAnggota,
  });

  String? idAnggota;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idAnggota: json["id_anggota"],
      );

  Map<String, dynamic> toJson() => {
        "id_anggota": idAnggota,
      };
}
