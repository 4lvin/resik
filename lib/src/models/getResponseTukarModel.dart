// To parse this JSON data, do
//
//     final getResponseTukarModel = getResponseTukarModelFromJson(jsonString);

import 'dart:convert';

class GetResponseTukarModel {
  bool the0;
  Message message;

  GetResponseTukarModel({
    this.the0,
    this.message,
  });

  factory GetResponseTukarModel.fromRawJson(String str) => GetResponseTukarModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetResponseTukarModel.fromJson(Map<String, dynamic> json) => GetResponseTukarModel(
    the0: json["0"],
    message: Message.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "0": the0,
    "message": message.toJson(),
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
