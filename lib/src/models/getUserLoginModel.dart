// To parse this JSON data, do
//
//     final getUserLoginModel = getUserLoginModelFromJson(jsonString);

import 'dart:convert';

class GetUserLoginModel {
  GetUserLoginModel({
    this.status,
    this.data,
    this.message,
  });

  bool? status;
  Data? data;
  String? message;

  factory GetUserLoginModel.fromRawJson(String str) =>
      GetUserLoginModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetUserLoginModel.fromJson(Map<String, dynamic> json) =>
      GetUserLoginModel(
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
    this.idToken,
    this.idAnggota,
    this.namaAnggota,
    this.image,
    this.idDesa,
  });

  String? idToken;
  String? idAnggota;
  String? namaAnggota;
  dynamic? image;
  String? idDesa;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idToken: json["id_token"],
        idAnggota: json["id_anggota"],
        namaAnggota: json["nama_anggota"],
        image: json["image"],
        idDesa: json["id_desa"],
      );

  Map<String, dynamic> toJson() => {
        "id_token": idToken,
        "id_anggota": idAnggota,
        "nama_anggota": namaAnggota,
        "image": image,
        "id_desa": idDesa,
      };
}
