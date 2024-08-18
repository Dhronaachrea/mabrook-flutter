part of 'auth_bloc.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {}

class AuthLoggedIn extends AuthState {
  String version;
  FlavorConfig? config;

  AuthLoggedIn(this.version, this.config);
}

class AuthLoggedOut extends AuthState {}
