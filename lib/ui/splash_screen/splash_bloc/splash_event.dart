part of 'splash_bloc.dart';

abstract class SplashEvent {}

class LogPrefs extends SplashEvent {}

class UserLogIn extends SplashEvent {
  final BuildContext context;

  UserLogIn(this.context);
}

class CheckVersionControl extends SplashEvent {
  final BuildContext context;

  CheckVersionControl(this.context);
}