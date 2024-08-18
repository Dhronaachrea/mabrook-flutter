// To parse this JSON data, do
//
//     final deepLinkResponse = deepLinkResponseFromJson(jsonString);

import 'dart:convert';

DeepLinkResponse deepLinkResponseFromJson(String str) =>
    DeepLinkResponse.fromJson(json.decode(str));

String deepLinkResponseToJson(DeepLinkResponse data) =>
    json.encode(data.toJson());

class DeepLinkResponse {
  DeepLinkResponse({
    this.data,
  });

  List<Datum>? data;

  factory DeepLinkResponse.fromJson(Map<String, dynamic> json) =>
      DeepLinkResponse(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<Datum>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.gameCode,
    this.code,
  });

  String? gameCode;
  String? code;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        gameCode: json["gameCode"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "gameCode": gameCode,
        "code": code,
      };
}
