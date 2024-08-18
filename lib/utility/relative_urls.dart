import 'package:mabrook/utility/user_info.dart';

class RelativeUrls {

  RelativeUrls() {
    print("RelativeUrls Constructor called !");
  }
  //---------------------------------------RMS-------------------------------------------\\

  static final String sendRegisterOtp             = "${UserInfo.decodedMap.baseApiDetails!["RAM"]}/preLogin/sendRegOtp";
  static final String registerWithOtp             = "${UserInfo.decodedMap.baseApiDetails!["RAM"]}/preLogin/registerPlayerWithOtp";
  static final String signInWithPassword          = "${UserInfo.decodedMap.baseApiDetails!["RAM"]}/preLogin/playerLogin";
  static final String playerProfile               = "${UserInfo.decodedMap.baseApiDetails!["RAM"]}/postLogin/playerProfile";
  static final String overallUpdatePlayerProfile  = "${UserInfo.decodedMap.baseApiDetails!["RAM"]}/postLogin/overallUpdatePlayerProfile";
  static final String sendVerificationEmailLink   = "${UserInfo.decodedMap.baseApiDetails!["RAM"]}/postLogin/sendVerficationEmailLink";
  static final String verifyEmailWithOtp          = "${UserInfo.decodedMap.baseApiDetails!["RAM"]}/postLogin/verifyEmailWithOtp";

  //---------------------------------------DMS-------------------------------------------\\

  static final String buyTicket                   = "${UserInfo.decodedMap.baseApiDetails!["DMS"]}/DMS/ticket/buy";
  static final String getTicketDetails            = "${UserInfo.decodedMap.baseApiDetails!["DMS"]}/DMS/ticket/getTicketDetails";

  //---------------------------------------VMS-------------------------------------------\\

  static final String getPlayerCoupon             = "${UserInfo.decodedMap.baseApiDetails!["VMS"]}/client/getPlayerCoupon";
  static final String activateCoupon              = "${UserInfo.decodedMap.baseApiDetails!["VMS"]}/client/activateCoupon";

  //---------------------------------------WEAVER-------------------------------------------\\

  static final String checkAvailability           = "${UserInfo.decodedMap.baseApiDetails!["WEAVER"]}/Weaver/service/rest/checkAvailability";
  static final String forgotPassword              = "${UserInfo.decodedMap.baseApiDetails!["WEAVER"]}/Weaver/service/rest/forgotPassword";
  static final String resetPassword               = "${UserInfo.decodedMap.baseApiDetails!["WEAVER"]}/Weaver/service/rest/resetPassword";
  static final String profileImageUpload          = "${UserInfo.decodedMap.baseApiDetails!["WEAVER"]}/Weaver/service/rest/uploadAvatar";
  static final String checkUpdateVersion          = "${UserInfo.decodedMap.baseApiDetails!["WEAVER"]}/Weaver/service/rest/versionControl";

}