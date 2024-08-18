part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent {
  const ForgotPasswordEvent();
}

class ForgotPasswordInitialEvent extends ForgotPasswordEvent {}

class ForgotPasswordCallApiEvent extends ForgotPasswordEvent {
  String mobile;

  ForgotPasswordCallApiEvent(this.mobile);
}

class ForgotPasswordWithPasswordLoadingEvent extends ForgotPasswordEvent {}

class ForgotPasswordWithPasswordSuccessEvent extends ForgotPasswordEvent {}

class ForgotPasswordWithPasswordErrorEvent extends ForgotPasswordEvent {}
