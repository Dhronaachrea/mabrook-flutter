import 'package:mabrook/models/response/register_response.dart';

abstract class SignInState {
  const SignInState();
}

class SignInInitialState extends SignInState {}

class SignInWithPasswordCallApiState extends SignInState {}

class SignInWithPasswordLoadingState extends SignInState {}

class SignInWithPasswordSuccessState extends SignInState {}

class SignInWithPasswordErrorState extends SignInState {
  String errorMessage;
  SignInWithPasswordErrorState(this.errorMessage);
}


/* -------- Below States are for when you enter mobile & request for SignIn with Otp -------- */
class LoginOtpSentLoadingState extends SignInState {}

class LoginOtpSentSuccessState extends SignInState {
  RegisterResponse? response;
  LoginOtpSentSuccessState(this.response);
}

class LoginOtpSentDeniedState extends SignInState {}

// LoginOtpSentErrorState, triggered when you have entered Invalid/ Incorrect Mobile no.
class LoginOtpSentErrorState extends SignInState {
  String errorMessage;
  LoginOtpSentErrorState(this.errorMessage);
}


 /* -------- Below States are for when you enter mobile & otp for SignIn with Otp -------- */
class OtpLoginLoadingState extends SignInState {}

class OtpLoginSuccessState extends SignInState {}

// OtpLoginErrorState, triggered when you have entered Invalid/ Incorrect Otp.
class OtpLoginErrorState extends SignInState {
  String errorMessage;

  OtpLoginErrorState(this.errorMessage);
}
