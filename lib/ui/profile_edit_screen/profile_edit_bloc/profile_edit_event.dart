import 'package:flutter/cupertino.dart';
import 'package:mabrook/models/response/get_player_coupon_response.dart';

abstract class ProfileEditEvent {
  const ProfileEditEvent();
}

class ProfileEditInitialEvent extends ProfileEditEvent {}

class ProfileEditLoadingEvent extends ProfileEditEvent {}

class ProfileEditApiCallEvent extends ProfileEditEvent {
  BuildContext? context;
  String? firstname;
  String? lastname;
  String? dob;
  String? email;

  ProfileEditApiCallEvent(this.context, this.firstname, this.lastname, this.dob, this.email);
}

class ProfileEditSuccessEvent extends ProfileEditEvent {
  GetPlayerCouponResponse response;

  ProfileEditSuccessEvent(this.response);
}

class ProfileEditErrorEvent extends ProfileEditEvent {
  String errorMessage;

  ProfileEditErrorEvent(this.errorMessage);
}



