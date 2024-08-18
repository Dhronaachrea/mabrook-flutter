
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabrook/models/request/check_availability_request.dart';
import 'package:mabrook/models/response/check_availability_response.dart';
import 'package:mabrook/models/response/register_response.dart';
import 'package:mabrook/models/response/register_with_otp_response.dart';
import 'package:mabrook/repository/register_repository.dart';
import 'package:mabrook/repository/sign_in_repository.dart';
import 'package:mabrook/ui/sign_in_screen/sign_in_bloc/sign_in_event.dart';
import 'package:mabrook/ui/sign_in_screen/sign_in_bloc/sign_in_state.dart';
import 'package:mabrook/utility/app_constant.dart';
import 'package:mabrook/utility/user_info.dart';
import 'package:mabrook/utility/utils.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitialState()) {
    on<SignInWithPasswordCallApiEvent>(_callPlayerLoginApi);
    on<SentLoginOtpEvent>(_callGetOtpLoginApi);
    on<OtpLoginCallApiEvent>(_callOtpLoginCallApi);
    on<CheckMobileNoAvailability>(_onCheckMobileNoAvailabilityEvent);

  }

  _callPlayerLoginApi(SignInWithPasswordCallApiEvent event, Emitter<SignInState> emit) async{
    emit(SignInWithPasswordLoadingState());

    Map<String, dynamic> request = {
      "requestIp"       : AppConstants.requestIp,
      "aliasName"       : AppConstants.aliasName,
      "domainName"      : AppConstants.domainName,
      "deviceType"      : AppConstants.deviceType,
      "userAgent"       : AppConstants.userAgent,
      "loginDevice"     : AppConstants.loginDevice,
      "ussd"            : "false",
      "userName"        : event.userName,
      "password"        : encryptMd5(encryptMd5(event.password) + AppConstants.loginTokenAsTimeStamp),
      "loginToken"      : AppConstants.loginTokenAsTimeStamp,
      "trackingCipher"  : "",
    };

    RegisterWithOtpResponse? response = await SignInRepository.callPlayerLogInApi(request);
    //var res = """{"firstDepositCampTrackId":0,"mapping":{},"domainName":"Mabrook","firstDepositReferSource":"","playerLoginInfo":{"unreadMsgCount":0,"lastName":"solanki","country":"KENYA","walletBean":{"totalBalance":1000000.0,"cashBalance":1000000.0,"depositBalance":0.0,"winningBalance":0.0,"bonusBalance":0.0,"withdrawableBal":0.0,"practiceBalance":10000.0,"currency":"KES","currencyDisplayCode":"KES","preferredWallet":"WEAVER","totalDepositBalance":0.0,"totalWithdrawableBalance":0.0},"gender":"M","autoPassword":"N","regDevice":"PC","ageVerified":"PENDING","emailId":"kapil@gmail.com","lastLoginDate":"2022-05-24 18:36:28.0","firstLoginDate":"2022-05-13 15:05:35.0","countryCode":"KE","playerType":"FREE","registrationDate":"2022-05-13 15:05:34.0","addressLine1":"fhfhfhfhhfh hhvhvf","state":"","playerStatus":"FULL","referSource":"NONE","addressVerified":"PENDING","playerId":11,"affilateId":1,"referFriendCode":"R3CYA","phoneVerified":"Y","avatarPath":"/playerImages/edit-thumbnai.jpg","mobileNo":"788888888","userName":"788888888","registrationIp":"10.160.10.50","olaPlayer":"Yes","lastLoginIP":"49.37.75.194","isPlay2x":"YES","firstName":"kapil","emailVerified":"N","dob":"05/04/2004","commonContentPath":"https://Mabrook/WeaverDoc/commonContent/Mabrook","firstDepositDate":"","requestedEmailId":"kapil@gmail.com"},"rummyDeepLink":"","firstDepositReferSourceId":0,"profileStatus":"NEW_UPLOAD_PENDING","errorCode":0,"firstDepositSubSourceId":0,"ramPlayerInfo":{"id":1385864,"merchantId":1,"domainId":1,"playerId":5,"addressVerified":"PENDING","nameVerified":"N","emailVerified":"N","mobileVerified":"Y","ageVerified":"PENDING","taxationIdVerified":"PENDING","securityQuestionVerified":"PENDING","idVerified":"PENDING","bankVerified":"PENDING","addressVerifiedAt":"13/05/2022 09:35:35","profileStatus":"NEW_UPLOAD_PENDING","kycStatus":"REGISTERED","emailVerifiedAt":"13/05/2022 09:35:35","mobileVerifiedAt":"13/05/2022 09:35:35","ageVerifiedAt":"13/05/2022 09:35:35","taxationIdVerifiedAt":"13/05/2022 09:35:35","securityQuestionVerifiedAt":"13/05/2022 09:35:35","idVerifiedAt":"13/05/2022 09:35:35","bankVerifiedAt":"13/05/2022 09:35:35","createdAt":"13/05/2022 09:35:35","updatedAt":"13/05/2022 09:35:35","profileExpiredAt":null,"docUploaded":"YES","uploadPendingDate":null,"verifiedBy":null,"verificationAssignAt":null,"verificationModeAt":null,"addressVerifiedBy":null,"idVerifiedBy":null,"bankVerifiedBy":null,"isMpinExist":"NO"},"playerToken":"f1ba4394bba9e0fbb03ee3c7b814f555"}""";
    //RegisterWithOtpResponse rawBuyTicketResponseObj = RegisterWithOtpResponse.fromJson(jsonDecode(res));
    if (response.errorCode == 0) {
      UserInfo.setPlayerToken(response.playerToken ?? "");
      UserInfo.setMobileNo(response.playerLoginInfo?.mobileNo ?? "");
      UserInfo.setPlayerId(response.playerLoginInfo?.playerId ?? -1);
      UserInfo.setPlayerEmailVerified(response.playerLoginInfo?.emailVerified ?? "N");

      emit(SignInWithPasswordSuccessState());
    } else if (response.errorCode == AppConstants.sessionExpiryCode) {
      showUserConfirmationDialog("Session Expired!", "Cancel", "LogIn Again", true);
    } else {
      emit(SignInWithPasswordErrorState(response.errorMessage.toString()));
    }
  }

  _callGetOtpLoginApi(SentLoginOtpEvent event, Emitter<SignInState> emit) async{
    emit(LoginOtpSentLoadingState());

    Map<String, dynamic> request = {
      "mobileNo": event.mobileNo,
      "aliasName": AppConstants.aliasName
    };

    RegisterResponse? response = await RegisterRepository.callRegisterApi(request);

    if (response.errorCode == 0 ) {
      emit(LoginOtpSentSuccessState(response));
    } else {
      emit(LoginOtpSentErrorState(response.errorMessage.toString()));
    }
  }

  _callOtpLoginCallApi(OtpLoginCallApiEvent event, Emitter<SignInState> emit) async{
    emit(OtpLoginLoadingState());

    Map<String, dynamic> request = {
      "userName"          : "",
      "password"          : "",
      "mobileNo"          : event.mobileNo,
      "otp"               : event.otp,
      "requestIp"         : AppConstants.requestIp,
      "registrationType"  : "FULL",
      "currencyId"        : AppConstants.currencyId,
      "currencyCode"      : AppConstants.currencyCode,
      "dob"               : null,
      "referCode"         : "",
      "firstName"         : null,
      "lastName"          : null,
      "countryCode"       : AppConstants.countryCode,
      "aliasName"         : AppConstants.aliasName,
      "domainName"        : AppConstants.domainName,
      "deviceType"        : AppConstants.deviceType,
      "userAgent"         : AppConstants.userAgent,
      "loginDevice"       : AppConstants.loginDevice
    };

    RegisterWithOtpResponse? response = await RegisterRepository.callRegisterWithOtpApi(request);

    if (response.errorCode == 0) {
      UserInfo.setPlayerToken(response.playerToken ?? "");
      UserInfo.setMobileNo(response.playerLoginInfo?.mobileNo ?? "");
      UserInfo.setPlayerId(response.playerLoginInfo?.playerId ?? -1);
      emit(OtpLoginSuccessState());
    } else {
      emit(OtpLoginErrorState(response.errorMessage.toString()));
    }
  }

  _onCheckMobileNoAvailabilityEvent(CheckMobileNoAvailability event, Emitter<SignInState> emit) async {
    String mobileNumber = event.mobileNumber;
    BuildContext context = event.context;
    CheckAvailabilityRequest request = CheckAvailabilityRequest(
        domainName: AppConstants.domainName,
        userName: mobileNumber
    );
    CheckAvailabilityResponse? response = await SignInRepository.checkAvailability(
        request.toJson());
    if (response != null) {
      if (response.errorCode == 0) {
        emit(LoginOtpSentDeniedState());

      } else if (response.errorCode == 505) {
        BlocProvider.of<SignInBloc>(context)
            .add(SentLoginOtpEvent(event.mobileNumber));
      }
    }
  }

}