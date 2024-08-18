/// errorCode : 0
/// respMsg : "Verification Code to reset your password has been sent to your Email Id and Mobile No"

class ForgotPasswordResponse {
  ForgotPasswordResponse({
      int? errorCode, 
      String? respMsg,}){
    _errorCode = errorCode;
    _respMsg = respMsg;
}

  ForgotPasswordResponse.fromJson(dynamic json) {
    _errorCode = json['errorCode'];
    _respMsg = json['respMsg'];
  }
  int? _errorCode;
  String? _respMsg;
ForgotPasswordResponse copyWith({  int? errorCode,
  String? respMsg,
}) => ForgotPasswordResponse(  errorCode: errorCode ?? _errorCode,
  respMsg: respMsg ?? _respMsg,
);
  int? get errorCode => _errorCode;
  String? get respMsg => _respMsg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['errorCode'] = _errorCode;
    map['respMsg'] = _respMsg;
    return map;
  }

}