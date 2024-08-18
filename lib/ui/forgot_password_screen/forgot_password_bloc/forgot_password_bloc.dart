import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabrook/models/response/forgot_password_response.dart';
import 'package:mabrook/repository/forgotpassword_repository.dart';
import 'package:mabrook/utility/app_constant.dart';

part 'forgot_password_event.dart';

part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ForgotPasswordCallApiEvent>(_callForgotPasswordAPI);
  }
}

_callForgotPasswordAPI(
    ForgotPasswordCallApiEvent event, Emitter<ForgotPasswordState> emit) async {
  emit(ForgotPasswordInitial());

  Map<String, dynamic> request = {
    "mobileNo": event.mobile,
    "domainName": AppConstants.aliasName
  };

  ForgotPasswordResponse? response = await ForgotPasswordRepository.callForgotPasswordApi(request);

  if (response.errorCode == 0) {
    emit(ForgotPasswordSuccessState(response));

  } else {
    emit(ForgotPasswordErrorState(response.respMsg.toString()));

  }
}
