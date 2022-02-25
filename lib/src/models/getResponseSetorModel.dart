// To parse this JSON data, do
//
//     final getResponseSetorModel = getResponseSetorModelFromJson(jsonString);

import 'dart:convert';

class GetResponseSetorModel {
  GetResponseSetorModel({
    this.status,
    this.data,
    this.message,
  });

  bool? status;
  Data? data;
  String? message;

  factory GetResponseSetorModel.fromRawJson(String str) =>
      GetResponseSetorModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetResponseSetorModel.fromJson(Map<String, dynamic> json) =>
      GetResponseSetorModel(
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
    this.idSetor,
    this.idDesa,
    this.idAnggota,
    this.tanggal,
    this.detailSetor,
  });

  String? idSetor;
  String? idDesa;
  String? idAnggota;
  DateTime? tanggal;
  List<DetailSetor>? detailSetor;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idSetor: json["id_setor"],
        idDesa: json["id_desa"],
        idAnggota: json["id_anggota"],
        tanggal: DateTime.parse(json["tanggal"]),
        detailSetor: List<DetailSetor>.from(
            json["detail_setor"].map((x) => DetailSetor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id_setor": idSetor,
        "id_desa": idDesa,
        "id_anggota": idAnggota,
        "tanggal": tanggal!.toIso8601String(),
        "detail_setor": List<dynamic>.from(detailSetor!.map((x) => x.toJson())),
      };
}

class DetailSetor {
  DetailSetor({
    this.idSetor,
    this.idSampah,
    this.jumlah,
    this.harga,
    this.subTotal,
  });

  int? idSetor;
  String? idSampah;
  int? jumlah;
  String? harga;
  int? subTotal;

  factory DetailSetor.fromRawJson(String str) =>
      DetailSetor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DetailSetor.fromJson(Map<String, dynamic> json) => DetailSetor(
        idSetor: json["id_setor"],
        idSampah: json["id_sampah"],
        jumlah: json["jumlah"],
        harga: json["harga"],
        subTotal: json["sub_total"],
      );

  Map<String, dynamic> toJson() => {
        "id_setor": idSetor,
        "id_sampah": idSampah,
        "jumlah": jumlah,
        "harga": harga,
        "sub_total": subTotal,
      };
}
