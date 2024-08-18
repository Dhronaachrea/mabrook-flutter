part of 'reset_password_bloc.dart';


abstract class ResetPasswordState {
  const ResetPasswordState();

}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordInitialState extends ResetPasswordState {}

class ResetPasswordCallApiState extends ResetPasswordState {}

class ResetPasswordLoadingState extends ResetPasswordState {}

class ResetPasswordSuccessState extends ResetPasswordState {
  ForgotPasswordResponse response;

  ResetPasswordSuccessState(this.response);
}

class ResetPasswordErrorState extends ResetPasswordState {
  String errorMessage;
  ResetPasswordErrorState(this.errorMessage);
}