import 'dart:convert';
import 'package:http/http.dart';
import 'package:mabrook/models/response/ProfileImageUploadResponse.dart';
import 'package:mabrook/models/response/activate_coupon_response.dart';
import 'package:mabrook/models/response/buy_ticket_response.dart';
import 'package:mabrook/models/response/check_availability_response.dart';
import 'package:mabrook/models/response/forgot_password_response.dart';
import 'package:mabrook/models/response/get_player_coupon_response.dart';
import 'package:mabrook/models/response/player_edit_profile_response.dart';
import 'package:mabrook/models/response/player_profile_response.dart';
import 'package:mabrook/models/response/register_response.dart';
import 'package:mabrook/models/response/register_with_otp_response.dart';
import 'package:mabrook/models/response/send_verification_link_response.dart';
import 'package:mabrook/models/response/ticket_details_response.dart';
import 'package:mabrook/models/response/verify_email_with_otp_response.dart';
import 'package:mabrook/models/response/version_response.dart';
import 'package:mabrook/utility/app_constant.dart';
import 'package:mabrook/utility/relative_urls.dart';
import 'package:mabrook/utility/shared_prefs.dart';
import 'package:mabrook/utility/user_info.dart';
import 'package:mabrook/utility/utils.dart';

import '../models/response/version_response.dart';

class ApiCall {
  static var headers = {
    "merchantCode"  : AppConstants.merchantCode,
    "Content-Type"  : "application/json; charset=UTF-8",
    "accept"        : "*/*"
  };

  static var headersWithMerchantPassword = {
    "merchantCode"  : AppConstants.merchantCode,
    "Content-Type"  : "application/json; charset=UTF-8",
    "accept"        : "*/*",
    "merchantPwd"   : AppConstants.merchantPwd
  };

  static var headersForBuyTicket = {
    "merchantCode"  : "merchantCode",
    "password"      : "password",
    "username"      : "weaver",
    "Content-Type"  : "application/json; charset=UTF-8",
    "accept"        : "*/*",
  };

  static var headersWithPlayerTokenAndId = {
    "merchantCode"  : AppConstants.merchantCode,
    "playerId"      : UserInfo.userId.toString(),
    "playerToken"   : SharedPrefUtils.playerToken,
    "Content-Type"  : "application/json; charset=UTF-8",
    "accept"        : "*/*",
  };

  static var headersWithPlayerTokenAndIdMultipart = {
    "merchantCode"  : AppConstants.merchantCode,
    "playerId"      : UserInfo.userId.toString(),
    "playerToken"   : SharedPrefUtils.playerToken,
    "Content-Type"  : "multipart/form-data",
  };

  /*------------------------------------------------------------------------------------------------------------------------------------*/

  static Future<RegisterResponse> callRegisterApi(Map<String, dynamic> request) async {
    var client              = Client();
    String queryString      = Uri(queryParameters: request).query;
    final Response response = await client.get(
      Uri.parse('${RelativeUrls.sendRegisterOtp}?$queryString'),
      headers: headers,
    );

    printRequestAndResponse(response, request, headers);

    return RegisterResponse.fromJson(jsonDecode(response.body));
  }

  static Future<RegisterWithOtpResponse> callRegisterWithOtpApi(Map<String, dynamic> request) async {
    var client              = Client();
    final Response response = await client.post(
      Uri.parse(RelativeUrls.registerWithOtp),
      headers: headers,
      body: jsonEncode(request)
    );

    printRequestAndResponse(response, request, headers);

    return RegisterWithOtpResponse.fromJson(jsonDecode(response.body));
  }

  static Future<RegisterWithOtpResponse> callPlayerLogInApi(Map<String, dynamic> request) async {
    var client              = Client();
    final Response response = await client.post(
      Uri.parse(RelativeUrls.signInWithPassword),
      headers: headers,
      body: jsonEncode(request)
    );

    printRequestAndResponse(response, request, headers);

    return RegisterWithOtpResponse.fromJson(jsonDecode(response.body));
  }

  static Future<GetPlayerCouponResponse> callGetPlayerCouponApi(Map<String, dynamic> request) async {
    var client              = Client();
    final Response response = await client.post(
        Uri.parse(RelativeUrls.getPlayerCoupon),
        headers: headersWithMerchantPassword,
        body: jsonEncode(request)
    );

    printRequestAndResponse(response, request, headersWithMerchantPassword);

    return GetPlayerCouponResponse.fromJson(jsonDecode(response.body));
  }

  static Future<BuyTicketResponse> callBuyTicketApi(Map<String, dynamic> request) async {
    var client              = Client();
    final Response response = await client.post(
        Uri.parse(RelativeUrls.buyTicket),
        headers: headersForBuyTicket,
        body: jsonEncode(request)
    );

    printRequestAndResponse(response, request, headersForBuyTicket);

    return BuyTicketResponse.fromJson(jsonDecode(response.body));
  }

  static Future<ActivateCouponResponse> callActivateCouponApi(Map<String, dynamic> request) async {
    var client              = Client();
    final Response response = await client.post(
        Uri.parse(RelativeUrls.activateCoupon),
        headers: headersWithMerchantPassword,
        body: jsonEncode(request)
    );

    printRequestAndResponse(response, request, headersWithMerchantPassword);

    return ActivateCouponResponse.fromJson(jsonDecode(response.body));
  }

  static Future<CheckAvailabilityResponse> checkAvailability(Map<String, dynamic> request) async {
    var client              = Client();
    final Response response = await client.post(
        Uri.parse(RelativeUrls.checkAvailability),
        headers: headers,
        body: jsonEncode(request)
    );

    printRequestAndResponse(response, request, headers);

    return CheckAvailabilityResponse.fromJson(jsonDecode(response.body));
  }

  static Future<ForgotPasswordResponse> forgotPassword(Map<String, dynamic> request) async {
    var client = Client();
    final Response response = await client.post(
        Uri.parse(RelativeUrls.forgotPassword),
        headers: headers,
        body: jsonEncode(request));

    printRequestAndResponse(response, request, headers);

    return ForgotPasswordResponse.fromJson(jsonDecode(response.body));
  }

  static Future<ForgotPasswordResponse> restPassword(Map<String, dynamic> request) async {
    var client = Client();
    final Response response = await client.post(
        Uri.parse(RelativeUrls.resetPassword),
        headers: headers,
        body: jsonEncode(request));

    printRequestAndResponse(response, request, headers);

    return ForgotPasswordResponse.fromJson(jsonDecode(response.body));
  }

  static Future<TicketDetailsResponse> getTicketDetails(Map<String, dynamic> request) async {
    print("111111111111111111111111111111111111");
    var headers = {
      'accept': '*/*',
      'Content-Type': 'application/json',
      'password': 'password',
      'username': 'weaver'
    };

    var client = Client();
    String queryString = Uri(queryParameters: request).query;
    final Response response = await client.get(
      Uri.parse('${RelativeUrls.getTicketDetails}?$queryString'),
      headers: headers,
    );

    printRequestAndResponse(response, request, headers);

    return TicketDetailsResponse.fromJson(jsonDecode(response.body));
  }

  static Future<PlayerProfileResponse> callPlayerProfileApi(Map<String, dynamic> request, Map<String, String> headers) async {
    var client              = Client();
    final Response response = await client.post(
        Uri.parse(RelativeUrls.playerProfile),
        headers: headers,
        body: jsonEncode(request)
    );

    printRequestAndResponse(response, request, headers);

    return PlayerProfileResponse.fromJson(jsonDecode(response.body));
  }

  static Future<PlayerEditProfileResponse> callOverallUpdatePlayerProfileApi(Map<String, String> request, Map<String, String> headers) async {

    final requestMultiPart = MultipartRequest('POST', Uri.parse(RelativeUrls.overallUpdatePlayerProfile));
    requestMultiPart.fields.addAll(request);
    requestMultiPart.headers.addAll(headers);

    StreamedResponse? response = await requestMultiPart.send();
    var streamData = await response.stream.bytesToString(); // Final Response in "streamData" variable

    printMultipartRequestAndResponse(streamData.toString(), request.toString(), headers);
    return PlayerEditProfileResponse.fromJson(jsonDecode(streamData));
  }

  static Future<ProfileImageUploadResponse> callProfileImageUploadApi(Map<String, String> request, Map<String, String> headers, MultipartFile file) async {

    final requestMultiPart = MultipartRequest('POST', Uri.parse(RelativeUrls.profileImageUpload));
    requestMultiPart.fields.addAll(request);
    requestMultiPart.headers.addAll(headers);
    requestMultiPart.files.addAll([file]);

    StreamedResponse? response = await requestMultiPart.send();
    var streamData = await response.stream.bytesToString(); // Final Response in "streamData" variable

    printMultipartRequestAndResponse(streamData.toString(), request.toString(), headers);
    return ProfileImageUploadResponse.fromJson(jsonDecode(streamData));
  }

  static Future<SendVerificationLinkResponse> callSendVerificationLinkApi(Map<String, dynamic> request, Map<String, String> headers) async {
    var client              = Client();
    final Response response = await client.post(
        Uri.parse(RelativeUrls.sendVerificationEmailLink),
        headers: headers,
        body: jsonEncode(request)
    );

    printRequestAndResponse(response, request, headers);

    return SendVerificationLinkResponse.fromJson(jsonDecode(response.body));
  }

  static Future<VerifyEmailWithOtpResponse> callVerifyEmailWithOtpApi(Map<String, dynamic> request, Map<String, String> headers) async {
    var client              = Client();
    final Response response = await client.post(
        Uri.parse(RelativeUrls.verifyEmailWithOtp),
        headers: headers,
        body: jsonEncode(request)
    );

    printRequestAndResponse(response, request, headers);

    return VerifyEmailWithOtpResponse.fromJson(jsonDecode(response.body));
  }

  static Future<VersionResponse> checkVersionApi(
      Map<String, dynamic> request) async {

    var client = Client();
    final Response response = await client.post(
        Uri.parse(RelativeUrls.checkUpdateVersion),
        headers: headers,
        body: jsonEncode(request));

    printRequestAndResponse(response, request, headers);

    return VersionResponse.fromJson(jsonDecode(response.body));
  }
}