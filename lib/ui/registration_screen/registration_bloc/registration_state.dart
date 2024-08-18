
import 'package:mabrook/models/response/register_response.dart';

abstract class RegistrationState {
  const RegistrationState();
}

class RegistrationInitialState extends RegistrationState {}

class RegisterCallApiState extends RegistrationState {}

class RegisterLoadingState extends RegistrationState {}

class RegisterSuccessState extends RegistrationState {
  RegisterResponse response;
  RegisterSuccessState(this.response);
}

class RegisterErrorState extends RegistrationState {
  String errorMessage;
  int errorCode;
  RegisterErrorState(this.errorMessage, this.errorCode);
}