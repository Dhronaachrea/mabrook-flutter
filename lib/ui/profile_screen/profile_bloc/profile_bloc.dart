import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mabrook/models/response/ProfileImageUploadResponse.dart';
import 'package:mabrook/models/response/player_profile_response.dart';
import 'package:mabrook/models/response/send_verification_link_response.dart';
import 'package:mabrook/models/response/verify_email_with_otp_response.dart';
import 'package:mabrook/repository/email_repository.dart';
import 'package:mabrook/repository/profile_repository.dart';
import 'package:mabrook/utility/app_constant.dart';
import 'package:mabrook/utility/shared_prefs.dart';
import 'package:mabrook/utility/user_info.dart';
import 'package:mabrook/utility/utils.dart';
import 'package:http/http.dart' as http;

import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(PlayerProfileInitialState()) {
    on<PlayerProfileApiCallEvent>(_callPlayerProfileApiCallEvent);
    on<EmailVerifyApiCallEvent>(_callEmailVerifyApiCall);
    on<VerifyEmailWithOtpApiCallEvent>(_callVerifyEmailWithOtpApiCallEvent);
    on<ProfileImageUploadApiCallEvent>(_callProfileImageUploadApiCallEvent);
  }

  _callPlayerProfileApiCallEvent(PlayerProfileApiCallEvent event, Emitter<ProfileState> emit) async{
    emit(PlayerProfileLoadingState());

    Map<String, dynamic> request = {
        "aliasName"     : AppConstants.aliasName,
        "domainName"    : AppConstants.domainName,
        "playerId"      : SharedPrefUtils.playerId,
        "playerToken"   : SharedPrefUtils.playerToken,
        "profile"       :"mabrook"
    };

    var headersWithPlayerTokenAndId = {
      "merchantCode"  : AppConstants.merchantCode,
      "playerId"      : UserInfo.userId.toString(),
      "playerToken"   : SharedPrefUtils.playerToken,
      "Content-Type"  : "application/json; charset=UTF-8",
      "accept"        : "*/*",
    };

    PlayerProfileResponse? response = await ProfileRepository.callPlayerProfileApi(request, headersWithPlayerTokenAndId);
    if (response.errorCode == 0) {
      //UserInfo.setPlayerInfo(jsonEncode(response.playerInfoBean));
      UserInfo.setPlayerFirstname(response.playerInfoBean?.firstName ?? "");
      UserInfo.setPlayerLastname(response.playerInfoBean?.lastName ?? "");
      UserInfo.setPlayerDob(response.basicPlayerInfo?.dateOfBirth.toString().split(" ")[0] ?? "");
      UserInfo.setPlayerEmailId(response.playerInfoBean?.emailId ?? "");
      UserInfo.setPlayerCountryCode(response.playerInfoBean?.countryCode ?? "");
      UserInfo.setPlayerProfileImage("${response.playerInfoBean?.commonContentPath}${response.playerInfoBean?.avatarPath}");
      UserInfo.setPlayerEmailVerified(response.playerInfoBean?.emailVerified ?? "N");
      emit(PlayerProfileSuccessState(response));

    } else if (response.errorCode == AppConstants.sessionExpiryCode) {
      showUserConfirmationDialog("Session Expired", "Cancel", "LogIn Again", true);
      emit(PlayerProfileSessionExpiredState());

    } else {
      emit(PlayerProfileErrorState("Something went wrong"));

    }
  }

  _callEmailVerifyApiCall(EmailVerifyApiCallEvent event, Emitter<ProfileState> emit) async{
    emit(EmailVerifyLoadingState());

    Map<String, dynamic> request = {
      "domainName"          : AppConstants.domainName,
      "emailId"             : event.emailId,
      "playerId"            : UserInfo.userId.toString(),
      "isOtpVerification"   : "YES",
    };

    var headersWithPlayerTokenAndId = {
      "merchantCode"  : AppConstants.merchantCode,
      "playerId"      : UserInfo.userId.toString(),
      "playerToken"   : SharedPrefUtils.playerToken,
      "Content-Type"  : "application/json; charset=UTF-8",
      "accept"        : "*/*",
    };

    SendVerificationLinkResponse? response = await EmailRepository.callSendVerificationLinkApi(request, headersWithPlayerTokenAndId);
    //var resp = """{"errorMessage":"Invalid Response Found From Communication","errorCode":0}""";
    //SendVerificationLinkResponse rawSenVerificationResponseObj = SendVerificationLinkResponse.fromJson(jsonDecode(resp));

    if (response.errorCode == 0) {
      emit(EmailVerifySuccessState());

    } else if (response.errorCode == AppConstants.sessionExpiryCode) {
      showUserConfirmationDialog("Session Expired", "Cancel", "LogIn Again", true);
      emit(PlayerProfileSessionExpiredState());

    } else {
      emit(EmailVerifyErrorState(response.errorMessage.toString()));

    }
  }

  _callVerifyEmailWithOtpApiCallEvent(VerifyEmailWithOtpApiCallEvent event, Emitter<ProfileState> emit) async{
    emit(VerifyEmailWithOtpLoadingState());

    Map<String, dynamic> request = {
      "domainName"          : AppConstants.domainName,
      "emailId"             : event.emailId,
      "merchantPlayerId"    : UserInfo.userId.toString(),
      "otp"                 : event.otp
    };

    var headersWithPlayerTokenAndId = {
      "merchantCode"  : AppConstants.merchantCode,
      "playerId"      : UserInfo.userId.toString(),
      "playerToken"   : SharedPrefUtils.playerToken,
      "Content-Type"  : "application/json; charset=UTF-8",
      "accept"        : "*/*",
    };

    VerifyEmailWithOtpResponse? response = await EmailRepository.callVerifyEmailWithOtpApi(request, headersWithPlayerTokenAndId);
    //var resp = """{"errorMessage":"Success","errorCode":0,"data":"EMAIL VERIFIED"}""";
    //VerifyEmailWithOtpResponse rawVerifyEmailWithOtpResponseObj = VerifyEmailWithOtpResponse.fromJson(jsonDecode(resp));

    if (response.errorCode == 0) {
      UserInfo.setPlayerEmailVerified("Y");
      emit(VerifyEmailWithOtpSuccessState(response));
    } else if (response.errorCode == AppConstants.sessionExpiryCode) {
      showUserConfirmationDialog("Session Expired", "Cancel", "LogIn Again", true);
      emit(PlayerProfileSessionExpiredState());

    } else {
      emit(VerifyEmailWithOtpErrorState(response.errorMessage.toString()));
    }
  }

  _callProfileImageUploadApiCallEvent(ProfileImageUploadApiCallEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileImageUploadLoadingState());

    BuildContext context            = event.context;
    FileTypeOptions selectedOption  = event.selectedOption;

    var sourceOfSelectedOption      = _getImageSourceOfSelectedOption(selectedOption);
    log("sourceOfSelectedOption: $sourceOfSelectedOption");
    XFile xFile;
    dynamic file;

    if (sourceOfSelectedOption == null) {
      return;
    } else {
      try {
        xFile = await _pickProfileImage(sourceOfSelectedOption, context);
        var fileType = xFile.name.split(".")[1];
        if (fileType.toString().toLowerCase() == "jpg" || fileType.toString().toLowerCase() == "jpeg" || fileType.toString().toLowerCase() == "png") {
          file = await http.MultipartFile.fromPath("file", xFile.path, filename: xFile.name);

        } else {
          emit(ProfileImageUploadErrorState("Only JPG/JPEG/PNG allowed"));

        }

      } catch (e) {
        emit(ProfileImageUploadCancelState());
        log(e.toString());
      }
    }

    Map<String, String> request = {
      "domainName"        : AppConstants.domainName,
      "playerId"          : UserInfo.userId.toString(),
      "playerToken"       : UserInfo.userToken,
      "isDefaultAvatar"   : "N",
    };

    var headersWithPlayerTokenAndIdMultipart = {
      "merchantCode"      : AppConstants.merchantCode,
      "playerId"          : UserInfo.userId.toString(),
      "playerToken"       : SharedPrefUtils.playerToken,
      "Content-Type"      : "multipart/form-data",
    };

    if (file != null) {
      ProfileImageUploadResponse? response = await ProfileRepository.callProfileImageUploadApi(request, headersWithPlayerTokenAndIdMultipart, file);

      if (response.errorCode == 0) {
        emit(ProfileImageUploadSuccessState(response));
      } else if (response.errorCode == AppConstants.sessionExpiryCode) {
        showUserConfirmationDialog("Session Expired", "Cancel", "LogIn Again", true);
        emit(ProfileImageSessionExpiredState());

      } else {
        emit(ProfileImageUploadErrorState(response.errorMessage.toString()));

      }
    } else {
      log("selectedFile for upload: $file");
    }
  }
}

_getImageSourceOfSelectedOption(FileTypeOptions selectedOption) {
  ImageSource? source;
  if (selectedOption == FileTypeOptions.camera) {
    source = ImageSource.camera;
  } else if (selectedOption == FileTypeOptions.gallery) {
    source = ImageSource.gallery;
  } else {
    source = null;
  }
  return source;
}

_pickProfileImage(source, context) async {
  XFile? xFile;
  xFile = await ImagePicker().pickImage(
    source: source,
    maxWidth: 1800,
    maxHeight: 1800,
  );

  if (xFile != null) {
    return xFile;
  }
}