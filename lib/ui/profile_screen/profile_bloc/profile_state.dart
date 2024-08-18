import 'package:mabrook/models/response/ProfileImageUploadResponse.dart';
import 'package:mabrook/models/response/player_profile_response.dart';
import 'package:mabrook/models/response/verify_email_with_otp_response.dart';

abstract class ProfileState {
  const ProfileState();
}

class PlayerProfileInitialState extends ProfileState{}

class PlayerProfileLoadingState extends ProfileState{}

class PlayerProfileSessionExpiredState extends ProfileState{}

class PlayerProfileSuccessState extends ProfileState{
  PlayerProfileResponse response;

  PlayerProfileSuccessState(this.response);
}
class PlayerProfileErrorState extends ProfileState{
  String errorMessage;

  PlayerProfileErrorState(this.errorMessage);
}

class EmailVerifyLoadingState extends ProfileState {}

class EmailVerifyApiCallState extends ProfileState {}

class EmailVerifySuccessState extends ProfileState {}

class EmailVerifyErrorState extends ProfileState {
  String errorMessage;

  EmailVerifyErrorState(this.errorMessage);
}


class VerifyEmailWithOtpLoadingState extends ProfileState {}

class VerifyEmailWithOtpApiCallState extends ProfileState {}

class VerifyEmailWithOtpSuccessState extends ProfileState {
  VerifyEmailWithOtpResponse response;

  VerifyEmailWithOtpSuccessState(this.response);
}

class VerifyEmailWithOtpErrorState extends ProfileState {
  String errorMessage;

  VerifyEmailWithOtpErrorState(this.errorMessage);
}

class ProfileImageUploadLoadingState extends ProfileState {}

class ProfileImageUploadApiCallState extends ProfileState {}

class ProfileImageSessionExpiredState extends ProfileState {}

class ProfileImageUploadSuccessState extends ProfileState {
  ProfileImageUploadResponse response;

  ProfileImageUploadSuccessState(this.response);
}

class ProfileImageUploadCancelState extends ProfileState {}

class ProfileImageUploadErrorState extends ProfileState {
  String? errorMessage;

  ProfileImageUploadErrorState(this.errorMessage);
}

