// To parse this JSON data, do
//
//     final getResponseTukarModel = getResponseTukarModelFromJson(jsonString);

import 'dart:convert';

class GetResponseTukarModel {
  GetResponseTukarModel({
    this.status,
    this.data,
    this.message,
  });

  bool status;
  Data data;
  String message;

  factory GetResponseTukarModel.fromRawJson(String str) => GetResponseTukarModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetResponseTukarModel.fromJson(Map<String, dynamic> json) => GetResponseTukarModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  Data({
    this.idTukar,
  });

  String idTukar;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    idTukar: json["id_tukar"],
  );

  Map<String, dynamic> toJson() => {
    "id_tukar": idTukar,
  };
}
