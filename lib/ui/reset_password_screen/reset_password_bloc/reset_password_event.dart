part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent {
  const ResetPasswordEvent();
}

class ResetPasswordInitialEvent extends ResetPasswordEvent {}

class ResetPasswordCallApiEvent extends ResetPasswordEvent {
  String mobile;
  String otp;
  String newPassword;
  String confirmPassword;

  ResetPasswordCallApiEvent(
      this.otp, this.newPassword, this.confirmPassword, this.mobile);
}

class ResetPasswordWithPasswordLoadingEvent extends ResetPasswordEvent {}

class ResetPasswordWithPasswordSuccessEvent extends ResetPasswordEvent {}

class ResetPasswordWithPasswordErrorEvent extends ResetPasswordEvent {}
