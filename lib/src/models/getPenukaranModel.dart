// To parse this JSON data, do
//
//     final getPenukaranModel = getPenukaranModelFromJson(jsonString);

import 'dart:convert';

class GetPenukaranModel {
  GetPenukaranModel({
    this.status,
    this.data,
    this.message,
  });

  bool status;
  List<Datum> data;
  String message;

  factory GetPenukaranModel.fromRawJson(String str) => GetPenukaranModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetPenukaranModel.fromJson(Map<String, dynamic> json) => GetPenukaranModel(
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
    this.idPenukaran,
    this.idKategori,
    this.idDesa,
    this.keterangan,
    this.icon,
  });

  String idPenukaran;
  String idKategori;
  String idDesa;
  String keterangan;
  String icon;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idPenukaran: json["id_penukaran"],
    idKategori: json["id_kategori"],
    idDesa: json["id_desa"],
    keterangan: json["keterangan"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id_penukaran": idPenukaran,
    "id_kategori": idKategori,
    "id_desa": idDesa,
    "keterangan": keterangan,
    "icon": icon,
  };
}
