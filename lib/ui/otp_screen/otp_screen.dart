import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabrook/l10n/l10n.dart';
import 'package:mabrook/models/request/otp_model.dart';
import 'package:mabrook/models/response/deep_link_response.dart';
import 'package:mabrook/repository/scan_voucher_respository.dart';
import 'package:mabrook/ui/otp_screen/otp_bloc/otp_bloc.dart';
import 'package:mabrook/ui/registration_screen/registration_bloc/registration_bloc.dart';
import 'package:mabrook/ui/registration_screen/registration_bloc/registration_event.dart';
import 'package:mabrook/ui/registration_screen/registration_bloc/registration_state.dart';
import 'package:mabrook/utility/app_constant.dart';
import 'package:mabrook/utility/app_data.dart';
import 'package:mabrook/utility/colors.dart';
import 'package:mabrook/utility/notification.dart';
import 'package:mabrook/utility/screens.dart';
import 'package:mabrook/utility/shared_prefs.dart';
import 'package:mabrook/utility/user_info.dart';
import 'package:mabrook/utility/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class OtpScreen extends StatefulWidget {
  final OtpModel otpModel;

  const OtpScreen({
    Key? key,
    required this.otpModel,
  }) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _one      = TextEditingController();
  final _two      = TextEditingController();
  final _three    = TextEditingController();
  final _four     = TextEditingController();
  final _five     = TextEditingController();
  final _six      = TextEditingController();

  List<String> voucherList  = [];
  bool _isSubmitButtonClickable = true;
  bool _isResendButtonClickable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocConsumer<OtpBloc, OtpState>(
            builder: (context, state) {
              return Scaffold(
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Image.asset(
                                  'assets/icons/back.png',
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(34, 0, 0, 0),
                              child: Text(
                                context.l10n.enterOtp,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(34, 0, 0, 0),
                              child: Text(
                                context.l10n.sixDigitCode,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(34, 0, 0, 0),
                              child: Text(
                                "on ${widget.otpModel.mobileNo}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  otpBoxBuilder(_one),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  otpBoxBuilder(_two),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  otpBoxBuilder(_three),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  otpBoxBuilder(_four),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  otpBoxBuilder(_five),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  otpBoxBuilder(_six),
                                ],
                              ),
                            ),
                            const SizedBox(height: 50),
                            Center(
                              child: Text.rich(TextSpan(
                                  text: context.l10n.haveNotReceived,
                                  style: const TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.w400),
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: context.l10n.resend,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          if (_isResendButtonClickable) {
                                            _isResendButtonClickable = false;
                                            BlocProvider.of<RegistrationBloc>(context).add(RegisterCallApiEvent(widget.otpModel.firstName, widget.otpModel.mobileNo, widget.otpModel.dob, widget.otpModel.email, widget.otpModel.password));
                                            }
                                          },
                                      style: const TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.w700),
                                    )
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(34, 20, 34, 0),
                              child: Center(
                                child: Container(
                                  width: double.infinity,
                                  child: TextButton(
                                      child: Text(context.l10n.cap_submit,
                                          style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w600)),
                                      style: ButtonStyle(
                                          padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              const EdgeInsets.all(15)),
                                          foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                          backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.black),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(18.0),
                                              ))),
                                      onPressed: () {
                                        if (_isSubmitButtonClickable) {
                                          _isSubmitButtonClickable = false;
                                          String otp = _one.text + _two.text + _three.text + _four.text + _five.text + _six.text;

                                          BlocProvider.of<OtpBloc>(context).add(
                                              CallRegisterWithOtpApiEvent(
                                                  otp,
                                                  widget.otpModel.mobileNo,
                                                  widget.otpModel.password,
                                                  widget.otpModel.dob,
                                                  widget.otpModel.email,
                                                  widget.otpModel.firstName
                                              ));
                                        }

                                      }),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            listener: (context, state) {
              if (state is OtpSuccessState) {
                //Navigator.pop(context);
                //showSnackBar(context, "Register Successfully, Now Please Sign-In", Colors.green);
                registrationSuccess();
                //Navigator.of(context).pushNamedAndRemoveUntil(Screen.home_screen, (route) => false);

              } else if (state is OtpErrorState) {
                _isSubmitButtonClickable = true;
                _one.clear();
                _two.clear();
                _three.clear();
                _four.clear();
                _five.clear();
                _six.clear();
                showSnackBar(context, state.errorMessage, Colors.red);
              } 
            },
          ),
          BlocConsumer<RegistrationBloc, RegistrationState>(
              builder: (context, state) {
                if (state is RegisterLoadingState) {
                  log("loading");
                  return Container(
                    color: MabrookColor.lightTransparentGrey,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(color: Colors.black),
                          Text(context.l10n.please_wait,style: const TextStyle(color: MabrookColor.black, fontSize: 22, fontWeight: FontWeight.bold)).pOnly(top: 22)
                        ],
                      ),
                    ),
                  );
                }
                return Container();

              },
            listener: (context, state) {
                  if (state is RegisterSuccessState) {
                    _isResendButtonClickable = true;
                    PushNotification.show(otp: state.response.data?.mobVerificationCode ?? "NA");
                    //showSnackBar(context, "Otp Send Successfully", Colors.green);
                  } 
                },
              
              )
        ],
      ),
    );
  }

  Widget otpBoxBuilder(TextEditingController cont) {
    return Container(
      alignment: Alignment.center,
      height: 50,
      width: 40,
      child: TextField(
        textAlign: TextAlign.center,
        maxLength: 1,
        controller: cont,
        decoration: const InputDecoration(counterText: ""),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.w500,
        ),
        keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly, FilteringTextInputFormatter.deny(RegExp("[' ']"))],
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
            else if(value.isEmpty)
            {
              FocusScope.of(context).previousFocus();
            }
          }
      ),
    );
  }

  Future<void> registrationSuccess() async {
    if (AppData.voucherData != '') {
      var jsonMap = jsonDecode(AppData.voucherData);
      //DeepLinkResponse deepLinkResponse = DeepLinkResponse.fromJson(jsonMap);
      List<Datum>? data = jsonMap != null
          ? List<Datum>.from(jsonMap.map((x) => Datum.fromJson(x)))
          : null;
      if (data != null) {
        voucherList = [];
        for (var element in data) {
          voucherList.add(element.code!);
        }

        Map<String, dynamic> request = {
          "aliasName"     : AppConstants.aliasName,
          "couponCode"    : voucherList,
          "gameCode"      : "RAFFLE",
          "userId"        : "${UserInfo.userId}",
          "referenceId"   : "EngineRef",
          "serviceCode"   : "DRAW_GAMES",
          "providerCode"  : "DGE"
        };

        var response = await ScanVoucherRepository.callActivateCouponApi(request);
        await SharedPrefUtils.removeValue(PrefType.APP_PREF.value);
        if (response.errorCode == 0) {
          int? failedCouponCount      = response.data?.failedCouponCount;
          int? succeededCouponCount   = response.data?.successedCouponCount;
          int? totalCouponCount       = failedCouponCount! + succeededCouponCount!;
          String succeedCoupon        = succeededCouponCount > 1 ? "Coupons" : "Coupon";
          String totalCoupon          = totalCouponCount > 1 ? "Coupons" : "Coupon";
          showSnackBar(
            context,
            "$succeededCouponCount $succeedCoupon added successfully out of $totalCouponCount $totalCoupon",
            Colors.green,
          );
        } else if (response.errorCode == AppConstants.sessionExpiryCode) {
          showUserConfirmationDialog("Session Expired!", "Cancel", "LogIn Again", true);

        } else {
          if (response.errorCode == 12422) {
            showSnackBar(context, response.errorMessage.toString(), Colors.green);
          } else {
            showSnackBar(context, response.errorMessage.toString(), Colors.red);
          }


        }
      }

      Timer(const Duration(seconds: 2), () {
        Navigator.of(context).pushNamedAndRemoveUntil(Screen.home_screen, (route) => false);
        //Navigator.pushReplacementNamed(context, Screen.home_screen);
      });

    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(Screen.home_screen, (route) => false);

    }

  }
}
