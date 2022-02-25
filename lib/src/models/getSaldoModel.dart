// To parse this JSON data, do
//
//     final getSaldoModel = getSaldoModelFromJson(jsonString);

import 'dart:convert';

class GetSaldoModel {
  GetSaldoModel({
    this.status,
    this.data,
    this.message,
  });

  bool? status;
  List<Datum>? data;
  String? message;

  factory GetSaldoModel.fromRawJson(String str) =>
      GetSaldoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetSaldoModel.fromJson(Map<String, dynamic> json) => GetSaldoModel(
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
    this.namaAnggota,
    this.totalSetor,
    this.totalTukar,
    this.totalBerat,
    this.saldo,
  });

  String? idAnggota;
  String? namaAnggota;
  String? totalSetor;
  String? totalTukar;
  String? totalBerat;
  String? saldo;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idAnggota: json["id_anggota"],
        namaAnggota: json["nama_anggota"],
        totalSetor: json["total_setor"],
        totalTukar: json["total_tukar"],
        totalBerat: json["total_berat"],
        saldo: json["saldo"],
      );

  Map<String, dynamic> toJson() => {
        "id_anggota": idAnggota,
        "nama_anggota": namaAnggota,
        "total_setor": totalSetor,
        "total_tukar": totalTukar,
        "total_berat": totalBerat,
        "saldo": saldo,
      };
}
