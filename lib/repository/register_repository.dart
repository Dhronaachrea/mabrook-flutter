
import 'package:mabrook/models/response/check_availability_response.dart';
import 'package:mabrook/models/response/register_response.dart';
import 'package:mabrook/models/response/register_with_otp_response.dart';
import 'package:mabrook/network/api_call.dart';

class RegisterRepository {
  static Future<RegisterResponse> callRegisterApi(Map<String, dynamic> request) async{
    return await ApiCall.callRegisterApi(request);
  }

  static Future<RegisterWithOtpResponse> callRegisterWithOtpApi(Map<String, dynamic> request) async{
    return await ApiCall.callRegisterWithOtpApi(request);
  }

  static Future<CheckAvailabilityResponse> checkAvailability(Map<String, dynamic> request) async{
    return await ApiCall.checkAvailability(request);
  }


}