import 'package:mabrook/models/response/buy_ticket_response.dart';
import 'package:mabrook/models/response/get_player_coupon_response.dart';
import 'package:mabrook/network/api_call.dart';

class HomeRepository {
  static Future<GetPlayerCouponResponse> callGetPlayerCouponApi(Map<String, dynamic> request) async{

    return await ApiCall.callGetPlayerCouponApi(request);
  }

  static Future<BuyTicketResponse> callBuyTicketApi(Map<String, dynamic> request) async{
    return await ApiCall.callBuyTicketApi(request);
  }
}