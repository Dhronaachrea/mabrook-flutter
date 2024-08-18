import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabrook/models/response/player_edit_profile_response.dart';
import 'package:mabrook/repository/profile_repository.dart';
import 'package:mabrook/utility/app_constant.dart';
import 'package:mabrook/utility/screens.dart';
import 'package:mabrook/utility/shared_prefs.dart';
import 'package:mabrook/utility/user_info.dart';
import 'package:mabrook/utility/utils.dart';
import 'profile_edit_event.dart';
import 'profile__edit_state.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  ProfileEditBloc() : super(PlayerEditProfileInitialState()) {
    on<ProfileEditApiCallEvent>(_callPlayerEditProfileApiCallEvent);
  }

  _callPlayerEditProfileApiCallEvent(ProfileEditApiCallEvent event, Emitter<ProfileEditState> emit) async {
    emit(PlayerEditProfileLoadingState());
    BuildContext? context = event.context;
    Map<String, String> request = {
      "domainName": AppConstants.domainName,
      "merchantPlayerId": UserInfo.userId.toString(),
      "firstName": event.firstname.toString(),
      "lastName": event.lastname.toString(),
      "dob": event.dob.toString(),
      "emailId": event.email.toString()
    };

    var headersWithPlayerTokenAndIdMultipart = {
      "merchantCode"  : AppConstants.merchantCode,
      "playerId"      : UserInfo.userId.toString(),
      "playerToken"   : SharedPrefUtils.playerToken,
      "Content-Type"  : "multipart/form-data",
    };

    PlayerEditProfileResponse? response = await ProfileRepository.callOverallUpdatePlayerProfileApi(request, headersWithPlayerTokenAndIdMultipart);

    if (response.errorCode == 0) {
      emit(PlayerEditProfileSuccessState(response));
      if (context != null) {
        showSnackBar(context, "Profile Updated Successfully", Colors.green);

        Future.delayed(const Duration(milliseconds: 500), () {
          /*Navigator.pushReplacementNamed(context, Screen.home_screen);
          Navigator.pushNamed(context, Screen.profile_screen);*/
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).popAndPushNamed(Screen.profile_screen);
        });

      }

    }  else if (response.errorCode == AppConstants.sessionExpiryCode) {
      showUserConfirmationDialog("Session Expired", "Cancel", "LogIn Again", true);
      emit(PlayerEditProfileSessionExpiredState());

    } else {
      emit(PlayerEditProfileErrorState(response.errorMessage.toString()));

    }
  }
}