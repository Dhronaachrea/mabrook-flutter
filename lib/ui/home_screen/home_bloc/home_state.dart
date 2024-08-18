import 'package:mabrook/models/response/buy_ticket_response.dart';
import 'package:mabrook/models/response/get_player_coupon_response.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitialState extends HomeState{}

class HomeGetPlayerCouponLoadingState extends HomeState{}

class HomeGetPlayerCouponSessionExpiredState extends HomeState{}

class HomeGetPlayerCouponSuccessState extends HomeState{
  GetPlayerCouponResponse response;

  HomeGetPlayerCouponSuccessState(this.response);
}
class HomeGetPlayerCouponErrorState extends HomeState{
  String errorMessage;

  HomeGetPlayerCouponErrorState(this.errorMessage);
}

class HomeBuyTicketApiCallLoadingState extends HomeState {}

class HomeBuyTicketApiCallSuccessState extends HomeState{
  BuyTicketResponse? response;
  String? logoUrl;
  String? couponCode;
  String? couponName;

  HomeBuyTicketApiCallSuccessState(this.response, this.logoUrl, this.couponName, this.couponCode);
}

class HomeBuyTicketApiCallErrorState extends HomeState{
  String errorMessage;

  HomeBuyTicketApiCallErrorState(this.errorMessage);
}