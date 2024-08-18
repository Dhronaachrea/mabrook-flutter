import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabrook/models/response/forgot_password_response.dart';

import '../../../repository/reset_password_repository.dart';
import '../../../utility/app_constant.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordInitial()) {
    on<ResetPasswordCallApiEvent>(_callResetPasswordAPI);
  }
}

_callResetPasswordAPI(ResetPasswordCallApiEvent event, Emitter<ResetPasswordState> emit) async {
  emit(ResetPasswordLoadingState());

  Map<String, dynamic> request = {
    "mobileNo": event.mobile,
    "otp": event.otp,
    "newPassword": event.newPassword,
    "confirmPassword": event.confirmPassword,
    "domainName": AppConstants.aliasName
  };

  ForgotPasswordResponse? response = await ResetPasswordRepository.callResetPasswordApi(request);

  if (response.errorCode == 0) {
    emit(ResetPasswordSuccessState(response));

  } else {
    emit(ResetPasswordErrorState(response.respMsg.toString()));

  }
}
