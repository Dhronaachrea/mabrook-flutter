import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) => RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) => json.encode(data.toJson());

class RegisterResponse {
  RegisterResponse({
    required this.errorMessage,
    required this.errorCode,
    required this.data,
  });

  String? errorMessage;
  int? errorCode;
  Data? data;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
    errorMessage: json["errorMessage"],
    errorCode: json["errorCode"],
    data: json['data'] == null ? null : Data.fromJson(json['data']),
  );

  Map<String, dynamic> toJson() => {
    "errorMessage": errorMessage,
    "errorCode": errorCode,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    required this.mobVerificationExpiry,
    required this.mobVerificationCode,
    required this.emailId,
    required this.emailVerificationExpiry,
    required this.id,
    required this.mobileNo,
    required this.otpActionType,
    required this.domainId,
    required this.emailVerificationCode,
  });

  int? mobVerificationExpiry;
  String? mobVerificationCode;
  dynamic emailId;
  dynamic emailVerificationExpiry;
  int? id;
  String? mobileNo;
  String? otpActionType;
  int? domainId;
  dynamic emailVerificationCode;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mobVerificationExpiry: json["mobVerificationExpiry"],
    mobVerificationCode: json["mobVerificationCode"],
    emailId: json["emailId"],
    emailVerificationExpiry: json["emailVerificationExpiry"],
    id: json["id"],
    mobileNo: json["mobileNo"],
    otpActionType: json["otpActionType"],
    domainId: json["domainId"],
    emailVerificationCode: json["emailVerificationCode"],
  );

  Map<String, dynamic> toJson() => {
    "mobVerificationExpiry": mobVerificationExpiry,
    "mobVerificationCode": mobVerificationCode,
    "emailId": emailId,
    "emailVerificationExpiry": emailVerificationExpiry,
    "id": id,
    "mobileNo": mobileNo,
    "otpActionType": otpActionType,
    "domainId": domainId,
    "emailVerificationCode": emailVerificationCode,
  };
}
