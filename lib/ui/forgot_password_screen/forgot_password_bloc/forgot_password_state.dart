part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState {
  const ForgotPasswordState();

}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordInitialState extends ForgotPasswordState {}

class ForgotPasswordCallApiState extends ForgotPasswordState {}

class ForgotPasswordLoadingState extends ForgotPasswordState {}

class ForgotPasswordSuccessState extends ForgotPasswordState {
  ForgotPasswordResponse response;

  ForgotPasswordSuccessState(this.response);
}

class ForgotPasswordErrorState extends ForgotPasswordState {
  String errorMessage;
  ForgotPasswordErrorState(this.errorMessage);
}