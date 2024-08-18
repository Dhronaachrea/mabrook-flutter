abstract class ScanVoucherEvent {
  const ScanVoucherEvent();
}

class ScanVoucherInitialEvent extends ScanVoucherEvent {}

class ScanVoucherCallApiEvent extends ScanVoucherEvent {
  Map<String, dynamic> request;
  ScanVoucherCallApiEvent(this.request);
}
