import 'package:mabrook/models/response/forgot_password_response.dart';
import 'package:mabrook/network/api_call.dart';

class ResetPasswordRepository {
  static Future<ForgotPasswordResponse> callResetPasswordApi(
      Map<String, dynamic> request) async {
    return await ApiCall.restPassword(request);
  }
}
