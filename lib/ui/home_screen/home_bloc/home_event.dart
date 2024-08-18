import 'package:mabrook/models/response/buy_ticket_response.dart';
import 'package:mabrook/models/response/get_player_coupon_response.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class HomeInitialEvent extends HomeEvent {}

class HomeGetPlayerCouponApiCallEvent extends HomeEvent {
  final int pageNumber;
  final String? status;

  HomeGetPlayerCouponApiCallEvent({required this.pageNumber, required this.status});
}

class HomeGetPlayerCouponSuccessEvent extends HomeEvent {
  GetPlayerCouponResponse response;

  HomeGetPlayerCouponSuccessEvent(this.response);
}

class HomeGetPlayerCouponErrorEvent extends HomeEvent {
  String errorMessage;

  HomeGetPlayerCouponErrorEvent(this.errorMessage);
}

class HomeBuyTicketApiCallEvent extends HomeEvent {
  String? logoUrl;
  String? couponCode;
  String? couponName;

  HomeBuyTicketApiCallEvent(this.logoUrl, this.couponName, this.couponCode);
}

class HomeBuyTicketApiCallSuccessEvent extends HomeEvent {
  BuyTicketResponse response;

  HomeBuyTicketApiCallSuccessEvent(this.response);
}

class HomeBuyTicketApiCallErrorEvent extends HomeEvent {
  String errorMessage;

  HomeBuyTicketApiCallErrorEvent(this.errorMessage);
}
