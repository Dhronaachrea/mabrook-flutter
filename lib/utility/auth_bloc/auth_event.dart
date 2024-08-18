part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class UserLogout extends AuthEvent {}

class AppStarted extends AuthEvent {
  FlavorConfig? config;

  AppStarted(this.config);
}

class DeepLink extends AuthEvent {}
