// To parse this JSON data, do
//
//     final getInformasiModel = getInformasiModelFromJson(jsonString);

import 'dart:convert';

class GetInformasiModel {
  GetInformasiModel({
    this.status,
    this.data,
    this.message,
  });

  bool status;
  List<Datum> data;
  String message;

  factory GetInformasiModel.fromRawJson(String str) => GetInformasiModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetInformasiModel.fromJson(Map<String, dynamic> json) => GetInformasiModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class Datum {
  Datum({
    this.id,
    this.tanggal,
    this.keterangan,
  });

  String id;
  DateTime tanggal;
  String keterangan;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    tanggal: DateTime.parse(json["tanggal"]),
    keterangan: json["keterangan"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
    "keterangan": keterangan,
  };
}
