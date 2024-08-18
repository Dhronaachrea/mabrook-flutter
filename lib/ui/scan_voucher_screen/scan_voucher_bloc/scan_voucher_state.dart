import 'package:mabrook/models/response/activate_coupon_response.dart';

abstract class ScanVoucherState {
  const ScanVoucherState();
}

class ScanVoucherInitialState extends ScanVoucherState {}

class ScanVoucherCallApiState extends ScanVoucherState {}

class ScanVoucherLoadingState extends ScanVoucherState {}

class ScanVoucherSessionExpiredState extends ScanVoucherState {}

class ScanVoucherSuccessState extends ScanVoucherState {
  ActivateCouponResponse? response;

  ScanVoucherSuccessState(this.response);
}

class ScanVoucherErrorState extends ScanVoucherState {
  String errorMessage;
  ScanVoucherErrorState(this.errorMessage);
}