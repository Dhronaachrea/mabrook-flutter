import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabrook/models/response/buy_ticket_response.dart';
import 'package:mabrook/models/response/get_player_coupon_response.dart';
import 'package:mabrook/repository/home_repository.dart';
import 'package:mabrook/utility/app_constant.dart';
import 'package:mabrook/utility/shared_prefs.dart';
import 'package:mabrook/utility/user_info.dart';
import 'package:mabrook/utility/utils.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeGetPlayerCouponApiCallEvent>(_callHomeGetPlayerCouponCallApi);
    on<HomeBuyTicketApiCallEvent>(_callHomeBuyTicketApi);
  }

  _callHomeGetPlayerCouponCallApi(HomeGetPlayerCouponApiCallEvent event, Emitter<HomeState> emit) async{
    emit(HomeGetPlayerCouponLoadingState());
    log("--------------------->${event.status.toString()}");

    int pageNumber = event.pageNumber;
    Map<String, dynamic> request = {
        "aliasName"     : AppConstants.aliasName,
        "userId"        : UserInfo.userId,
        "serviceCode"   : "DRAW_GAMES",
        "gameCode"      : "RAFFLE",
        "providerCode"  : "DGE",
        "direction"     : "DESC",
        "page"          : pageNumber,
        "status"        : event.status == "ALL" ? null : event.status
    };
    GetPlayerCouponResponse? response = await HomeRepository.callGetPlayerCouponApi(request);

    if (response.errorCode == 0) {
      emit(HomeGetPlayerCouponSuccessState(response));

    } else if (response.errorCode == AppConstants.sessionExpiryCode) {
      showUserConfirmationDialog("Session Expired!", "Cancel", "LogIn Again", true);
      emit(HomeGetPlayerCouponErrorState(response.errorMessage.toString()));

    }else {
      //emit(HomeGetPlayerCouponErrorState(response.errorMessage.toString()));
      if (response.errorMessage != "Please Provide Valid Player Id") {
        emit(HomeGetPlayerCouponErrorState(errorCodeMapper(AppConstants.VMS, response.errorCode)));
      } else {
        emit(HomeGetPlayerCouponErrorState("Data Not Found!"));
      }

    }
  }

  _callHomeBuyTicketApi(HomeBuyTicketApiCallEvent event, Emitter<HomeState> emit) async{
    emit(HomeBuyTicketApiCallLoadingState());
    Map<String, dynamic> request = {
      "merchantCode"                : "Non_Trans",
      "noOfDraws"                   : "1",
      "gameCode"                    : "Raffle",
      "gameId"                      : "1",
      "isAdvancePlay"               : false,
      "isUpdatedPayoutConfirmed"    : false,
      "currencyCode"                : "SAR",
      "modelCode"                   : "NA",
      "purchaseDeviceId"            : "1",
      "couponCode"                  : event.couponCode,
      "lastTicketNumber"            : "0",
      "purchaseDeviceType"          : "B2C_MobileWeb",
      "drawData": [{
        "drawId"                    : "396"
      }
      ],
      "panelData": [{
        "betAmountMultiple"         : "1",
        "betType"                   : "Direct6",
        "pickConfig"                : "Number",
        "pickedValues"              : SharedPrefUtils.mobileNo,
        "pickType"                  : "Direct6",
        "qpPreGenerated"            : false
      }
      ],
      "merchantData": {
        "userName"                  : SharedPrefUtils.mobileNo,
        "aliasName"                 : AppConstants.aliasName,
        "userId"                    : UserInfo.userId,
        "sessionId"                 : UserInfo.userToken
      }
    };

    BuyTicketResponse? response = await HomeRepository.callBuyTicketApi(request);
    //var res = """{"responseCode": 0,"responseMessage": "Success","responseData": {"gameId": 1,"gameName": "Raffle","gameCode": "Raffle","totalPurchaseAmount": 2000.0,"playerPurchaseAmount": 2000.0,"purchaseTime": "20-05-2022 13:17:52","ticketNumber": "31001000000115055900","panelData": [{"betType": "Direct6","pickType": "Direct6","tpticketList": null,"pickConfig": "Number","betAmountMultiple": 1,"quickPick": false,"pickedValues": "788888888","qpPreGenerated": false,"numberOfLines": 1,"unitCost": 2000.0,"panelPrice": 2000.0,"playerPanelPrice": 2000.0,"betDisplayName": "Direct6","pickDisplayName": "Direct6","winningMultiplier": null}],"drawData": [{"drawName": "Raffle","drawDate": "01-07-2022","drawTime": "00:00:00","drawId": 712}],"merchantCode": "Non_Trans","currencyCode": "CDF","partyType": "PLAYER","channel": "B2C","validationCode": "---r-----g--u-x-j---","ticketExpiry": "1  Days","nativeCurrencyCode": "CDF","domainCode": "mabrook","noOfDraws": 1}}""";
    //BuyTicketResponse rawBuyTicketResponseObj = BuyTicketResponse.fromJson(jsonDecode(res));

    if (response.responseCode == 0) {
      log("couponCode: ${event.couponCode}");
      emit(HomeBuyTicketApiCallSuccessState(response, event.logoUrl, event.couponName, event.couponCode));

    } else if (response.responseCode == AppConstants.sessionExpiryCode) {
      showUserConfirmationDialog("Session Expired!", "Cancel", "LogIn Again", true);
      emit(HomeGetPlayerCouponSessionExpiredState());

    } else {
      emit(HomeBuyTicketApiCallErrorState(response.responseMessage.toString()));

    }
  }
}