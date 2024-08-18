import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabrook/flavor_config.dart';
import 'package:mabrook/utility/app_constant.dart';
import 'package:mabrook/utility/app_data.dart';
import 'package:mabrook/utility/screens.dart';
import 'package:mabrook/utility/shared_prefs.dart';
import 'package:mabrook/utility/user_info.dart';
import 'package:mabrook/utility/utils.dart';
import 'package:uni_links/uni_links.dart';

import '../../models/response/deep_link_response.dart';
import '../../repository/scan_voucher_respository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<UserLogout>(_onLogoutEvent);
    on<DeepLink>(_onDeepLink);
  }

  StreamSubscription? _streamSubscription;
  bool initialURILinkHandled = false;
  List<String> voucherList = [];

  _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    var version = await getVersion();

    emit(AuthLoggedIn(version, event.config));

    /*if (UserInfo.isLoggedIn()) {
      // if (context != null) {
      //   Timer(const Duration(seconds: 2), () {
      //     Navigator.pushReplacementNamed(context, Screen.home_screen);
      //   });
      // }
      //fullName = UserInfo.fullName;
      emit(AuthLoggedIn(version));
    }
    else {
      // if (context != null) {
      //   Timer(const Duration(seconds: 2), () {
      //     Navigator.pushReplacementNamed(context, Screen.login_screen);
      //   });
      // }
      emit(AuthLoggedOut());
    }*/
  }

  _onLogoutEvent(UserLogout event, Emitter<AuthState> emit) {
    emit(AuthLoggedOut());
  }

  FutureOr<void> _onDeepLink(DeepLink event, Emitter<AuthState> emit) {
    BuildContext? context = navigatorKey.currentContext;
    _initURIHandler(context);
    _incomingLinkHandler(context);
  }

  Future<void> _initURIHandler(BuildContext? context) async {
    if (!initialURILinkHandled) {
      log("init uri Handler is called");
      initialURILinkHandled = true;
      try {
        final uri = await getInitialUri();
        if (uri != null) {
          handleUri(uri, context);
        } else {
          log("Null Initial URI received");
        }
      } on PlatformException {
        log("Failed to receive initial uri");
      } on FormatException catch (err) {
        log('Malformed Initial URI received: $err');
      }
    }
  }

  void _incomingLinkHandler(BuildContext? context) {
    _streamSubscription = uriLinkStream.listen((Uri? uri) async {
      log('Received URI: $uri');
      if (uri != null) {
        handleUri(uri, context);
      }
    });
  }

  Future<void> handleUri(Uri uri, BuildContext? context) async {
    String? postData = uri.queryParameters["postData"];
    log("postData: $postData"); //{"data":[{"gameCode":"RAFFLE","code":"d4c8db6c-8793-4ade-9a2a-d82cba71ac96"}]}
    var body = json.decode(postData!);
    DeepLinkResponse? deepLinkingResponse = DeepLinkResponse.fromJson(body);
    List<Datum>? data = deepLinkingResponse.data;
    if (data != null) {
      voucherList = [];
      for (var element in data) {
        voucherList.add(element.code!);
      }
      if (context != null && UserInfo.isLoggedIn()) {
        Map<String, dynamic> request = {
          "aliasName": AppConstants.aliasName,
          "couponCode": voucherList,
          "gameCode": "RAFFLE",
          "userId": "${UserInfo.userId}",
          "referenceId": "EngineRef",
          "serviceCode": "DRAW_GAMES",
          "providerCode": "DGE"
        };
        var response = await ScanVoucherRepository.callActivateCouponApi(request);

        SharedPrefUtils.removeValue(PrefType.APP_PREF.value);
        if (response.errorCode == 0) {
          int? failedCouponCount = response.data?.failedCouponCount;
          int? succeededCouponCount = response.data?.successedCouponCount;
          int? totalCouponCount = failedCouponCount! + succeededCouponCount!;
          String succeedCoupon =
              succeededCouponCount > 1 ? "Coupons" : "Coupon";
          String totalCoupon = totalCouponCount > 1 ? "Coupons" : "Coupon";
          showSnackBar(
            context,
            "$succeededCouponCount $succeedCoupon added successfully out of $totalCouponCount $totalCoupon",
            Colors.green,
          );
          Timer(const Duration(seconds: 2), () {
            Navigator.pushReplacementNamed(context, Screen.home_screen);
          });
        } else if (response.errorCode == AppConstants.sessionExpiryCode) {
          showUserConfirmationDialog(
              "Session Expired!", "Cancel", "LogIn Again", true);
        } else {
          showSnackBar(context, response.errorMessage.toString(), Colors.red);
          Timer(const Duration(seconds: 2), () {
            Navigator.pushReplacementNamed(context, Screen.home_screen);
          });
        }
      } else {
        AppData.setVoucherData(json.encode(deepLinkingResponse.data));
      }
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
