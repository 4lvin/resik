// To parse this JSON data, do
//
//     final getHistoryModel = getHistoryModelFromJson(jsonString);

import 'dart:convert';

class GetHistoryModel {
  bool status;
  List<Datum> data;
  Message message;

  GetHistoryModel({
    this.status,
    this.data,
    this.message,
  });

  factory GetHistoryModel.fromRawJson(String str) => GetHistoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetHistoryModel.fromJson(Map<String, dynamic> json) => GetHistoryModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: Message.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message.toJson(),
  };
}

class Datum {
  DateTime tanggal;
  String keterangan;
  String harga;
  String kode;
  String tipe;
  String status;

  Datum({
    this.tanggal,
    this.keterangan,
    this.harga,
    this.kode,
    this.tipe,
    this.status,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    tanggal: DateTime.parse(json["tanggal"]),
    keterangan: json["keterangan"],
    harga: json["harga"],
    kode: json["kode"],
    tipe: json["tipe"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "tanggal": tanggal.toIso8601String(),
    "keterangan": keterangan,
    "harga": harga,
    "kode": kode,
    "tipe": tipe,
    "status": status,
  };
}

class Message {
  String massage;

  Message({
    this.massage,
  });

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    massage: json["massage"],
  );

  Map<String, dynamic> toJson() => {
    "massage": massage,
  };
}
