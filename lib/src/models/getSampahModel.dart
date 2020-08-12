// To parse this JSON data, do
//
//     final getSampahModel = getSampahModelFromJson(jsonString);

import 'dart:convert';

class GetSampahModel {
  List<Datum> data;
  Message message;

  GetSampahModel({
    this.data,
    this.message,
  });

  factory GetSampahModel.fromRawJson(String str) => GetSampahModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetSampahModel.fromJson(Map<String, dynamic> json) => GetSampahModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: Message.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message.toJson(),
  };
}

class Datum {
  String idSampah;
  String idJenis;
  String jenisSampah;
  String namaSampah;
  String hargaSetor;
  String hargaJual;
  String image;

  Datum({
    this.idSampah,
    this.idJenis,
    this.jenisSampah,
    this.namaSampah,
    this.hargaSetor,
    this.hargaJual,
    this.image,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idSampah: json["id_sampah"],
    idJenis: json["id_jenis"],
    jenisSampah: json["jenis_sampah"],
    namaSampah: json["nama_sampah"],
    hargaSetor: json["harga_setor"],
    hargaJual: json["harga_jual"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id_sampah": idSampah,
    "id_jenis": idJenis,
    "jenis_sampah": jenisSampah,
    "nama_sampah": namaSampah,
    "harga_setor": hargaSetor,
    "harga_jual": hargaJual,
    "image": image,
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
