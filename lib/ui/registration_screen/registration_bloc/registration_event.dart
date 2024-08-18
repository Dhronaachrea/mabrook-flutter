import 'package:flutter/material.dart';

abstract class RegistrationEvent {
  const RegistrationEvent();
}

class RegisterInitialEvent extends RegistrationEvent {}

class RegisterCallApiEvent extends RegistrationEvent {
  String name;
  String emailId;
  String dateOfBirth;
  String mobileNumber;
  String password;

  RegisterCallApiEvent( this.name, this.mobileNumber, this.dateOfBirth, this.emailId, this.password);
}

class RegisterLoadingEvent extends RegistrationEvent {}

class RegisterSuccessEvent extends RegistrationEvent {}

class RegisterErrorEvent extends RegistrationEvent {}

class RegisterCheckMobileNoAvailabilityEvent extends RegistrationEvent {
  String name;
  String emailId;
  String dateOfBirth;
  String mobileNumber;
  String password;
  BuildContext context;

  RegisterCheckMobileNoAvailabilityEvent(this.context,this.name, this.mobileNumber, this.dateOfBirth, this.emailId, this.password);
}
