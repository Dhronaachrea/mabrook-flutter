import 'dart:convert';
/// errorMessage : "Success"
/// errorCode : 0
/// data : "EMAIL VERIFIED"

VerifyEmailWithOtpResponse verifyEmailWithOtpResponseFromJson(String str) => VerifyEmailWithOtpResponse.fromJson(json.decode(str));
String verifyEmailWithOtpResponseToJson(VerifyEmailWithOtpResponse data) => json.encode(data.toJson());
class VerifyEmailWithOtpResponse {
  VerifyEmailWithOtpResponse({
      String? errorMessage, 
      int? errorCode, 
      String? data,}){
    _errorMessage = errorMessage;
    _errorCode = errorCode;
    _data = data;
}

  VerifyEmailWithOtpResponse.fromJson(dynamic json) {
    _errorMessage = json['errorMessage'];
    _errorCode = json['errorCode'];
    _data = json['data'];
  }
  String? _errorMessage;
  int? _errorCode;
  String? _data;

  String? get errorMessage => _errorMessage;
  int? get errorCode => _errorCode;
  String? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['errorMessage'] = _errorMessage;
    map['errorCode'] = _errorCode;
    map['data'] = _data;
    return map;
  }

}