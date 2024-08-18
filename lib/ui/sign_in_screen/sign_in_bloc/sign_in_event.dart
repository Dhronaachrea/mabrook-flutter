import 'package:flutter/material.dart';

abstract class SignInEvent {
  const SignInEvent();
}

class SignInInitialEvent extends SignInEvent {}

class SignInWithPasswordCallApiEvent extends SignInEvent {
  String userName;
  String password;

  SignInWithPasswordCallApiEvent( this.userName, this.password);
}

class SignInWithPasswordLoadingEvent extends SignInEvent {}

class SignInWithPasswordSuccessEvent extends SignInEvent {}

class SignInWithPasswordErrorEvent extends SignInEvent {}

///////////////////////////////////////////////////////
class SentLoginOtpLoadingEvent extends SignInEvent {}

class SentLoginOtpEvent extends SignInEvent {
  String mobileNo;

  SentLoginOtpEvent( this.mobileNo);
}

class LoginOtpSentSuccessEvent extends SignInEvent {}

class LoginOtpSentErrorEvent extends SignInEvent {}

class OtpLoginLoadingEvent extends SignInEvent {}

class OtpLoginCallApiEvent extends SignInEvent {
  String mobileNo;
  String otp;

  OtpLoginCallApiEvent( this.mobileNo, this.otp);
}

class OtpLoginSuccessEvent extends SignInEvent {}

class OtpLoginErrorEvent extends SignInEvent {}

class CheckMobileNoAvailability extends SignInEvent {
  final String mobileNumber;
  final BuildContext context;

  CheckMobileNoAvailability({
    required this.mobileNumber,
    required this.context,
  });
}
