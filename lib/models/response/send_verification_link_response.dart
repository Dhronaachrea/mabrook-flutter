import 'dart:convert';
/// errorMessage : "Success"
/// errorCode : 0

SendVerificationLinkResponse sendVerificationLinkResponseFromJson(String str) => SendVerificationLinkResponse.fromJson(json.decode(str));
String sendVerificationLinkResponseToJson(SendVerificationLinkResponse data) => json.encode(data.toJson());
class SendVerificationLinkResponse {
  SendVerificationLinkResponse({
      String? errorMessage, 
      int? errorCode,}){
    _errorMessage = errorMessage;
    _errorCode = errorCode;
}

  SendVerificationLinkResponse.fromJson(dynamic json) {
    _errorMessage = json['errorMessage'];
    _errorCode = json['errorCode'];
  }
  String? _errorMessage;
  int? _errorCode;

  String? get errorMessage => _errorMessage;
  int? get errorCode => _errorCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['errorMessage'] = _errorMessage;
    map['errorCode'] = _errorCode;
    return map;
  }

}