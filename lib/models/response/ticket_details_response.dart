// To parse this JSON data, do
//
//     final ticketDetailsResponse = ticketDetailsResponseFromJson(jsonString);

import 'dart:convert';

TicketDetailsResponse ticketDetailsResponseFromJson(String str) =>
    TicketDetailsResponse.fromJson(json.decode(str));

String ticketDetailsResponseToJson(TicketDetailsResponse data) =>
    json.encode(data.toJson());

class TicketDetailsResponse {
  TicketDetailsResponse({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  int? responseCode;
  String? responseMessage;
  List<ResponseDatum>? responseData;

  factory TicketDetailsResponse.fromJson(Map<String, dynamic> json) =>
      TicketDetailsResponse(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        responseData: List<ResponseDatum>.from(
            json["responseData"].map((x) => ResponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "responseData": responseData == null
            ? null
            : List<ResponseDatum>.from(responseData!.map((x) => x.toJson())),
      };
}

class ResponseDatum {
  ResponseDatum({
    this.playerId,
    this.gameCode,
    this.gameName,
    this.ticketList,
  });

  String? playerId;
  String? gameCode;
  String? gameName;
  List<TicketList>? ticketList;

  factory ResponseDatum.fromJson(Map<String, dynamic> json) => ResponseDatum(
        playerId: json["playerId"],
        gameCode: json["gameCode"],
        gameName: json["gameName"],
        ticketList: List<TicketList>.from(
            json["ticketList"].map((x) => TicketList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "playerId": playerId,
        "gameCode": gameCode,
        "gameName": gameName,
        "ticketList": ticketList == null
            ? null
            : List<TicketList>.from(ticketList!.map((x) => x.toJson())),
      };
}

class TicketList {
  TicketList({
    this.ticketNumber,
    this.voucherNumber,
    this.transactionDate,
    this.drawDetails,
    this.ticketDetails,
    this.gameName,
  });

  String? ticketNumber;
  String? voucherNumber;
  DateTime? transactionDate;
  DrawDetails? drawDetails;
  TicketDetails? ticketDetails;
  String? gameName;

  factory TicketList.fromJson(Map<String, dynamic> json) => TicketList(
        ticketNumber: json["ticketNumber"],
        voucherNumber: json["voucherNumber"],
        transactionDate: DateTime.parse(json["transactionDate"]),
        drawDetails: DrawDetails.fromJson(json["drawDetails"]),
        ticketDetails: TicketDetails.fromJson(json["ticketDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "ticketNumber": ticketNumber,
        "voucherNumber": voucherNumber,
        "transactionDate": transactionDate?.toIso8601String(),
        "drawDetails": drawDetails?.toJson(),
        "ticketDetails": ticketDetails?.toJson(),
      };
}

class DrawDetails {
  DrawDetails({
    this.drawId,
    this.drawName,
    this.drawDateTime,
    this.drawStatus,
    this.drawNo,
  });

  int? drawId;
  String? drawName;
  DateTime? drawDateTime;
  String? drawStatus;
  int? drawNo;

  factory DrawDetails.fromJson(Map<String, dynamic> json) => DrawDetails(
        drawId: json["drawId"],
        drawName: json["drawName"],
        drawDateTime: DateTime.parse(json["drawDateTime"]),
        drawStatus: json["drawStatus"],
        drawNo: json["drawNo"],
      );

  Map<String, dynamic> toJson() => {
        "drawId": drawId,
        "drawName": drawName,
        "drawDateTime": drawDateTime?.toIso8601String(),
        "drawStatus": drawStatus,
        "drawNo": drawNo,
      };
}

class TicketDetails {
  TicketDetails({
    this.winstatus,
    this.saleAmount,
    this.numberOfPanels,
    this.winningAmount,
    this.txnCurrency,
    this.productInfo,
    this.txnTime,
    this.panelWisePickedValueList,
  });

  String? winstatus;
  double? saleAmount;
  int? numberOfPanels;
  double? winningAmount;
  String? txnCurrency;
  dynamic productInfo;
  DateTime? txnTime;
  List<PanelWisePickedValueList>? panelWisePickedValueList;

  factory TicketDetails.fromJson(Map<String, dynamic> json) => TicketDetails(
        winstatus: json["winstatus"],
        saleAmount: json["saleAmount"],
        numberOfPanels: json["numberOfPanels"],
        winningAmount: json["winningAmount"],
        txnCurrency: json["txnCurrency"],
        productInfo: json["productInfo"],
        txnTime: DateTime.parse(json["txnTime"]),
        panelWisePickedValueList: List<PanelWisePickedValueList>.from(
            json["panelWisePickedValueList"]
                .map((x) => PanelWisePickedValueList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "winstatus": winstatus,
        "saleAmount": saleAmount,
        "numberOfPanels": numberOfPanels,
        "winningAmount": winningAmount,
        "txnCurrency": txnCurrency,
        "productInfo": productInfo,
        "txnTime": txnTime?.toIso8601String(),
        "panelWisePickedValueList": panelWisePickedValueList == null
            ? null
            : List<PanelWisePickedValueList>.from(
                panelWisePickedValueList!.map((x) => x.toJson())),
      };
}

class PanelWisePickedValueList {
  PanelWisePickedValueList({
    this.pickedValues,
    this.panelId,
    this.winStatus,
    this.serialNo,
    this.saleAmount,
    this.winAmount,
  });

  List<String>? pickedValues;
  int? panelId;
  String? winStatus;
  int? serialNo;
  double? saleAmount;
  double? winAmount;

  factory PanelWisePickedValueList.fromJson(Map<String, dynamic> json) =>
      PanelWisePickedValueList(
        pickedValues: List<String>.from(json["pickedValues"].map((x) => x)),
        panelId: json["panelId"],
        winStatus: json["winStatus"],
        serialNo: json["serialNo"],
        saleAmount: json["saleAmount"],
        winAmount: json["winAmount"],
      );

  Map<String, dynamic> toJson() => {
        "pickedValues": pickedValues == null
            ? null
            : List<String>.from(pickedValues!.map((x) => x)),
        "panelId": panelId,
        "winStatus": winStatus,
        "serialNo": serialNo,
        "saleAmount": saleAmount,
        "winAmount": winAmount,
      };
}
