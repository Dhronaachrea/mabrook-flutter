import 'package:mabrook/utility/shared_prefs.dart';

class AppData {
  static final AppData _instance = AppData._ctor();

  factory AppData() {
    return _instance;
  }

  AppData._ctor();

  static setVoucherData(String data) {
    SharedPrefUtils.voucherData = data;
  }

  static String get voucherData => SharedPrefUtils.voucherData;
}
