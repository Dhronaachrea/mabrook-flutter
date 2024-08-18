import 'package:mabrook/models/response/send_verification_link_response.dart';
import 'package:mabrook/models/response/verify_email_with_otp_response.dart';
import 'package:mabrook/network/api_call.dart';

class EmailRepository {
  static Future<SendVerificationLinkResponse> callSendVerificationLinkApi(Map<String, dynamic> request, Map<String, String> headers) async{
    return await ApiCall.callSendVerificationLinkApi(request, headers);
  }

  static Future<VerifyEmailWithOtpResponse> callVerifyEmailWithOtpApi(Map<String, dynamic> request, Map<String, String> headers) async{
    return await ApiCall.callVerifyEmailWithOtpApi(request, headers);
  }
}