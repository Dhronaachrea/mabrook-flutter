import 'package:http/http.dart';
import 'package:mabrook/models/response/ProfileImageUploadResponse.dart';
import 'package:mabrook/models/response/player_edit_profile_response.dart';
import 'package:mabrook/models/response/player_profile_response.dart';
import 'package:mabrook/network/api_call.dart';

class ProfileRepository {
  static Future<PlayerProfileResponse> callPlayerProfileApi(Map<String, dynamic> request, Map<String, String> headers) async{
    return await ApiCall.callPlayerProfileApi(request, headers);
  }

  static Future<PlayerEditProfileResponse> callOverallUpdatePlayerProfileApi(Map<String, String> request, Map<String, String> headers) async{
    return await ApiCall.callOverallUpdatePlayerProfileApi(request, headers);
  }

  static Future<ProfileImageUploadResponse> callProfileImageUploadApi(Map<String, String> request, Map<String, String> headers, MultipartFile file) async{
    return await ApiCall.callProfileImageUploadApi(request, headers, file);
  }
}