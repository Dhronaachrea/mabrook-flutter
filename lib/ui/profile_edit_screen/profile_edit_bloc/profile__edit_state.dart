import 'package:mabrook/models/response/player_edit_profile_response.dart';

abstract class ProfileEditState {
  const ProfileEditState();
}

class PlayerEditProfileInitialState extends ProfileEditState{}

class PlayerEditProfileLoadingState extends ProfileEditState{}

class PlayerEditProfileSessionExpiredState extends ProfileEditState{}

class PlayerEditProfileSuccessState extends ProfileEditState{
  PlayerEditProfileResponse response;

  PlayerEditProfileSuccessState(this.response);
}
class PlayerEditProfileErrorState extends ProfileEditState{
  String errorMessage;

  PlayerEditProfileErrorState(this.errorMessage);
}


