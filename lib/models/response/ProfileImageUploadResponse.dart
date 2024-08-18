import 'dart:convert';
/// errorCode : 0
/// errorMessage : ""
/// avatarPath : "https://uat-weaver.mabroook.com/WeaverDoc/commonContent/Mabroook/playerImages/7_image.jpg"

ProfileImageUploadResponse profileImageUploadResponseFromJson(String str) => ProfileImageUploadResponse.fromJson(json.decode(str));
String profileImageUploadResponseToJson(ProfileImageUploadResponse data) => json.encode(data.toJson());
class ProfileImageUploadResponse {
  ProfileImageUploadResponse({
      int? errorCode, 
      String? errorMessage, 
      String? avatarPath,}){
    _errorCode = errorCode;
    _errorMessage = errorMessage;
    _avatarPath = avatarPath;
}

  ProfileImageUploadResponse.fromJson(dynamic json) {
    _errorCode = json['errorCode'];
    _errorMessage = json['errorMessage'];
    _avatarPath = json['avatarPath'];
  }
  int? _errorCode;
  String? _errorMessage;
  String? _avatarPath;

  int? get errorCode => _errorCode;
  String? get errorMessage => _errorMessage;
  String? get avatarPath => _avatarPath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['errorCode'] = _errorCode;
    map['errorMessage'] = _errorMessage;
    map['avatarPath'] = _avatarPath;
    return map;
  }

}