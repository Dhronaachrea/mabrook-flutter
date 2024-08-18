import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabrook/models/response/register_with_otp_response.dart';
import 'package:mabrook/repository/register_repository.dart';
import 'package:mabrook/utility/app_constant.dart';
import 'package:mabrook/utility/user_info.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(OtpInitialState()){
    on<CallRegisterWithOtpApiEvent>(_callRegisterWithOtpApi);
  }

  _callRegisterWithOtpApi(CallRegisterWithOtpApiEvent event , Emitter<OtpState> emit) async{
    emit(OtpLoadingState());
    Map<String, dynamic> request = {
      "userName"          : event.mobileNumber,
      "password"          : event.password,
      "mobileNo"          : event.mobileNumber,
      "otp"               : event.otp,
      "requestIp"         : AppConstants.requestIp,
      "registrationType"  : "FULL",
      "currencyId"        : AppConstants.currencyId,
      "currencyCode"      : AppConstants.currencyCode,
      "dob"               : event.dob,
      "referCode"         : "",
      "firstName"         : event.firstname,
      "lastName"          : null,
      "emailId"           : event.emailId,
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
        emit(OtpSuccessState());
    } else {
      emit(OtpErrorState(response.errorMessage.toString()));
    }
  }
}
