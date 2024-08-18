part of 'otp_bloc.dart';

abstract class OtpEvent {
  const OtpEvent();
}

class OtpInitialEvent extends OtpEvent {}

class CallRegisterWithOtpApiEvent extends OtpEvent {
  final String otp;
  final String mobileNumber;
  final String password;
  final String dob;
  final String emailId;
  final String firstname;

  CallRegisterWithOtpApiEvent(this.otp, this.mobileNumber, this.password, this.dob, this.emailId, this.firstname);
}

class OtpLoadingEvent extends OtpEvent {}

class OtpSuccessEvent extends OtpEvent {}

class OtpErrorEvent extends OtpEvent {}

