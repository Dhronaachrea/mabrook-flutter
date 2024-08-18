import 'package:flutter/cupertino.dart';
import 'package:mabrook/models/response/ProfileImageUploadResponse.dart';
import 'package:mabrook/models/response/get_player_coupon_response.dart';
import 'package:mabrook/models/response/send_verification_link_response.dart';
import 'package:mabrook/utility/utils.dart';

abstract class ProfileEvent {
  const ProfileEvent();
}

class ProfileInitialEvent extends ProfileEvent {}

class PlayerProfileApiCallEvent extends ProfileEvent {}

class PlayerProfileSuccessEvent extends ProfileEvent {
  GetPlayerCouponResponse response;

  PlayerProfileSuccessEvent(this.response);
}

class PlayerProfileErrorEvent extends ProfileEvent {
  String errorMessage;

  PlayerProfileErrorEvent(this.errorMessage);
}

class EmailVerifyLoadingEvent extends ProfileEvent {}

class EmailVerifyApiCallEvent extends ProfileEvent {
  String emailId;

  EmailVerifyApiCallEvent(this.emailId);
}

class EmailVerifySuccessEvent extends ProfileEvent {
  SendVerificationLinkResponse response;

  EmailVerifySuccessEvent(this.response);
}

class EmailVerifyErrorEvent extends ProfileEvent {
  String errorMessage;

  EmailVerifyErrorEvent(this.errorMessage);
}


class VerifyEmailWithOtpLoadingEvent extends ProfileEvent {}

class VerifyEmailWithOtpApiCallEvent extends ProfileEvent {
  String emailId;
  String otp;

  VerifyEmailWithOtpApiCallEvent(this.emailId, this.otp);
}

class VerifyEmailWithOtpSuccessEvent extends ProfileEvent {
  SendVerificationLinkResponse response;

  VerifyEmailWithOtpSuccessEvent(this.response);
}

class VerifyEmailWithOtpErrorEvent extends ProfileEvent {
  String errorMessage;

  VerifyEmailWithOtpErrorEvent(this.errorMessage);
}

class ProfileImageUploadLoadingEvent extends ProfileEvent {}

class ProfileImageUploadApiCallEvent extends ProfileEvent {
  BuildContext context;
  FileTypeOptions selectedOption;

  ProfileImageUploadApiCallEvent(this.context, this.selectedOption);
}

class ProfileImageUploadSuccessEvent extends ProfileEvent {
  ProfileImageUploadResponse response;

  ProfileImageUploadSuccessEvent(this.response);
}

class ProfileImageUploadErrorEvent extends ProfileEvent {
  String errorMessage;

  ProfileImageUploadErrorEvent(this.errorMessage);
}
