part of 'otp_bloc.dart';

abstract class OtpState {
  const OtpState();
}

class OtpInitialState extends OtpState {}

class CallRegisterWithOtpApiState extends OtpState {}

class OtpLoadingState extends OtpState {}

class OtpSuccessState extends OtpState {}

class OtpErrorState extends OtpState {
  String errorMessage;
  OtpErrorState(this.errorMessage);
}

