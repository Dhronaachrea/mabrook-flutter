import 'package:mabrook/models/response/activate_coupon_response.dart';
import 'package:mabrook/network/api_call.dart';

class ScanVoucherRepository {

  static Future<ActivateCouponResponse> callActivateCouponApi(Map<String, dynamic> request) async{
    return await ApiCall.callActivateCouponApi(request);
  }


}