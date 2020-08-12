// To parse this JSON data, do
//
//     final getResponseSetorModel = getResponseSetorModelFromJson(jsonString);

import 'dart:convert';

class GetResponseSetorModel {
  Message message;

  GetResponseSetorModel({
    this.message,
  });

  factory GetResponseSetorModel.fromRawJson(String str) => GetResponseSetorModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetResponseSetorModel.fromJson(Map<String, dynamic> json) => GetResponseSetorModel(
    message: Message.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message.toJson(),
  };
}

class Message {
  String idSetor;
  bool success;
  String message;

  Message({
    this.idSetor,
    this.success,
    this.message,
  });

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    idSetor: json["id_setor"],
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "id_setor": idSetor,
    "success": success,
    "message": message,
  };
}
