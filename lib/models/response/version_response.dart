import 'dart:convert';

VersionResponse versionResponseFromJson(String str) =>
    VersionResponse.fromJson(json.decode(str));

String versionResponseToJson(VersionResponse data) =>
    json.encode(data.toJson());

class VersionResponse {
  VersionResponse({
    required this.errorCode,
    required this.respMsg,
    required this.appDetails,
    required this.gameEngineInfo,
    required this.isplayerLogin,
    required this.staticLogoDisplay,
  });

  int errorCode;
  String respMsg;
  AppDetails? appDetails;
  GameEngineInfo? gameEngineInfo;
  bool isplayerLogin;
  bool? staticLogoDisplay;

  factory VersionResponse.fromJson(Map<String, dynamic> json) =>
      VersionResponse(
        errorCode: json["errorCode"],
        respMsg: json["respMsg"],
        appDetails: json["appDetails"] == null
            ? null
            : AppDetails.fromJson(json["appDetails"]),
        gameEngineInfo: json["gameEngineInfo"] == null
            ? null
            : GameEngineInfo.fromJson(json["gameEngineInfo"]),
        isplayerLogin: json["isplayerLogin"],
        staticLogoDisplay: json["staticLogoDisplay"],
      );

  Map<String, dynamic> toJson() => {
        "errorCode": errorCode,
        "respMsg": respMsg,
        "appDetails": appDetails?.toJson(),
        "gameEngineInfo": gameEngineInfo?.toJson(),
        "isplayerLogin": isplayerLogin,
        "staticLogoDisplay": staticLogoDisplay,
      };
}

class AppDetails {
  AppDetails({
    required this.isUpdateAvailable,
    this.message,
    this.version,
    this.mandatory,
    this.url,
  });

  bool isUpdateAvailable;
  String? message;
  String? version;
  bool? mandatory;
  String? url;

  factory AppDetails.fromJson(Map<String, dynamic> json) => AppDetails(
        isUpdateAvailable: json["isUpdateAvailable"],
        message: json["message"],
        version: json["version"],
        mandatory: json["mandatory"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "isUpdateAvailable": isUpdateAvailable,
        "message": message,
        "version": version,
        "mandatory": mandatory,
        "url": url,
      };
}

class GameEngineInfo {
  GameEngineInfo({
    required this.dge,
    required this.ige,
  });

  Dge dge;
  Dge ige;

  factory GameEngineInfo.fromJson(Map<String, dynamic> json) => GameEngineInfo(
        dge: Dge.fromJson(json["DGE"]),
        ige: Dge.fromJson(json["IGE"]),
      );

  Map<String, dynamic> toJson() => {
        "DGE": dge.toJson(),
        "IGE": ige.toJson(),
      };
}

class Dge {
  Dge({
    required this.serverUrl,
  });

  String serverUrl;

  factory Dge.fromJson(Map<String, dynamic> json) => Dge(
        serverUrl: json["serverUrl"],
      );

  Map<String, dynamic> toJson() => {
        "serverUrl": serverUrl,
      };
}
