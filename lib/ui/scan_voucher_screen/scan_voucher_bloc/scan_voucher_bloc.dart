
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabrook/models/response/activate_coupon_response.dart';
import 'package:mabrook/repository/scan_voucher_respository.dart';
import 'package:mabrook/ui/scan_voucher_screen/scan_voucher_bloc/scan_voucher_event.dart';
import 'package:mabrook/ui/scan_voucher_screen/scan_voucher_bloc/scan_voucher_state.dart';
import 'package:mabrook/utility/app_constant.dart';
import 'package:mabrook/utility/utils.dart';

class ScanVoucherBloc extends Bloc<ScanVoucherEvent, ScanVoucherState> {
  ScanVoucherBloc() : super(ScanVoucherInitialState()) {
    on<ScanVoucherCallApiEvent>(_callActivateCouponApi);
  }

  _callActivateCouponApi(ScanVoucherCallApiEvent event, Emitter<ScanVoucherState> emit) async{
    emit(ScanVoucherLoadingState());

    ActivateCouponResponse? response = await ScanVoucherRepository.callActivateCouponApi(event.request);
    if (response.errorCode == 0) {
      emit(ScanVoucherSuccessState(response));

    } else if (response.errorCode == AppConstants.sessionExpiryCode) {
      showUserConfirmationDialog("Session Expired!", "Cancel", "LogIn Again", true);
      emit(ScanVoucherSessionExpiredState());

    }else {
      emit(ScanVoucherErrorState(response.errorMessage.toString()));
    }

  }

}