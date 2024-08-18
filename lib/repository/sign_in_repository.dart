import 'package:mabrook/models/response/check_availability_response.dart';
import 'package:mabrook/models/response/register_with_otp_response.dart';
import 'package:mabrook/network/api_call.dart';

class SignInRepository {

  static Future<RegisterWithOtpResponse> callPlayerLogInApi(Map<String, dynamic> request) async{
    return await ApiCall.callPlayerLogInApi(request);
  }

  static Future<CheckAvailabilityResponse> checkAvailability(Map<String, dynamic> request) async{
    return await ApiCall.checkAvailability(request);
  }
}