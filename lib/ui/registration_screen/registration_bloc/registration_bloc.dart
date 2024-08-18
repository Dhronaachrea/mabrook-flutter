import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabrook/models/request/check_availability_request.dart';
import 'package:mabrook/models/response/check_availability_response.dart';
import 'package:mabrook/models/response/register_response.dart';
import 'package:mabrook/repository/register_repository.dart';
import 'package:mabrook/ui/registration_screen/registration_bloc/registration_event.dart';
import 'package:mabrook/ui/registration_screen/registration_bloc/registration_state.dart';
import 'package:mabrook/utility/app_constant.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitialState()) {
    on<RegisterCallApiEvent>(_callRegisterApi);
    on<RegisterCheckMobileNoAvailabilityEvent>(_onCheckMobileNoAvailabilityEvent);
  }

  _callRegisterApi(RegisterCallApiEvent event, Emitter<RegistrationState> emit) async{
    emit(RegisterLoadingState());

    Map<String, dynamic> request = {
      "name"      : event.name,
      "mobileNo"  : event.mobileNumber,
      "emailId"   : event.emailId,
      "dob"       : event.dateOfBirth,
      "password"  : event.password,
      "aliasName" : AppConstants.aliasName
    };

    RegisterResponse? response = await RegisterRepository.callRegisterApi(request);

    if (response.errorCode == 0 ) {
      emit(RegisterSuccessState(response));
    } else {
      emit(RegisterErrorState(response.errorMessage.toString() , response.errorCode ?? -2));
    }
  }

  _onCheckMobileNoAvailabilityEvent(RegisterCheckMobileNoAvailabilityEvent event, Emitter<RegistrationState> emit) async {
    String mobileNumber = event.mobileNumber;
    BuildContext context = event.context;
    CheckAvailabilityRequest request = CheckAvailabilityRequest(
        domainName: AppConstants.domainName,
        userName: mobileNumber
    );
    CheckAvailabilityResponse? response = await RegisterRepository.checkAvailability(
        request.toJson());
    if (response != null) {
      if (response.errorCode == 0) {

        BlocProvider.of<RegistrationBloc>(context).add(RegisterCallApiEvent(event.name, event.mobileNumber, event.dateOfBirth, event.emailId, event.password));

      } else if (response.errorCode == 505) {
        emit(RegisterErrorState(response.respMsg, response.errorCode));
      }
    }
  }
  
}