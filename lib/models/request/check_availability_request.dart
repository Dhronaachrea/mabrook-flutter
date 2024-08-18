// To parse this JSON data, do
//
//     final checkAvailabilityRequest = checkAvailabilityRequestFromJson(jsonString);

import 'dart:convert';

CheckAvailabilityRequest checkAvailabilityRequestFromJson(String str) => CheckAvailabilityRequest.fromJson(json.decode(str));

String checkAvailabilityRequestToJson(CheckAvailabilityRequest data) => json.encode(data.toJson());

class CheckAvailabilityRequest {
  CheckAvailabilityRequest({
    required this.userName,
    required this.domainName,
  });

  String userName;
  String domainName;

  factory CheckAvailabilityRequest.fromJson(Map<String, dynamic> json) => CheckAvailabilityRequest(
    userName: json["userName"],
    domainName: json["domainName"],
  );

  Map<String, dynamic> toJson() => {
    "userName": userName,
    "domainName": domainName,
  };
}
