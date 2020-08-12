// To parse this JSON data, do
//
//     final getUserLoginModel = getUserLoginModelFromJson(jsonString);

import 'dart:convert';

class GetUserLoginModel {
  bool status;
  Data data;
  Message message;

  GetUserLoginModel({
    this.status,
    this.data,
    this.message,
  });

  factory GetUserLoginModel.fromRawJson(String str) => GetUserLoginModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetUserLoginModel.fromJson(Map<String, dynamic> json) => GetUserLoginModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
    message: Message.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
    "message": message.toJson(),
  };
}

class Data {
  bool status;
  String idAnggota;
  String namaAnggota;
  String image;

  Data({
    this.status,
    this.idAnggota,
    this.namaAnggota,
    this.image,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
    idAnggota: json["id_anggota"],
    namaAnggota: json["nama_anggota"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "id_anggota": idAnggota,
    "nama_anggota": namaAnggota,
    "image": image,
  };
}

class Message {
  String message;

  Message({
    this.message,
  });

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
