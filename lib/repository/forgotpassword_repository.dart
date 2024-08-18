import 'package:mabrook/models/response/forgot_password_response.dart';
import 'package:mabrook/network/api_call.dart';

class ForgotPasswordRepository {
  static Future<ForgotPasswordResponse> callForgotPasswordApi(
      Map<String, dynamic> request) async {
    return await ApiCall.forgotPassword(request);
  }
}
