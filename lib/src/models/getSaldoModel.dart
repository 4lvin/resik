// To parse this JSON data, do
//
//     final getSaldoModel = getSaldoModelFromJson(jsonString);

import 'dart:convert';

class GetSaldoModel {
  List<Datum> data;
  Message message;

  GetSaldoModel({
    this.data,
    this.message,
  });

  factory GetSaldoModel.fromRawJson(String str) => GetSaldoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetSaldoModel.fromJson(Map<String, dynamic> json) => GetSaldoModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: Message.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message.toJson(),
  };
}

class Datum {
  String idAnggota;
  String namaAnggota;
  String totalSetor;
  String totalTukar;
  String saldo;

  Datum({
    this.idAnggota,
    this.namaAnggota,
    this.totalSetor,
    this.totalTukar,
    this.saldo,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idAnggota: json["id_anggota"],
    namaAnggota: json["nama_anggota"],
    totalSetor: json["total_setor"],
    totalTukar: json["total_tukar"],
    saldo: json["saldo"],
  );

  Map<String, dynamic> toJson() => {
    "id_anggota": idAnggota,
    "nama_anggota": namaAnggota,
    "total_setor": totalSetor,
    "total_tukar": totalTukar,
    "saldo": saldo,
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
