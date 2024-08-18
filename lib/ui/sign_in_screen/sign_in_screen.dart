import 'dart:convert';
import 'dart:developer';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabrook/l10n/l10n.dart';
import 'package:mabrook/models/response/deep_link_response.dart';
import 'package:mabrook/repository/scan_voucher_respository.dart';
import 'package:mabrook/ui/sign_in_screen/sign_in_bloc/sign_in_bloc.dart';
import 'package:mabrook/ui/sign_in_screen/sign_in_bloc/sign_in_event.dart';
import 'package:mabrook/ui/sign_in_screen/sign_in_bloc/sign_in_state.dart';
import 'package:mabrook/utility/app_constant.dart';
import 'package:mabrook/utility/app_data.dart';
import 'package:mabrook/utility/notification.dart';
import 'package:mabrook/utility/screens.dart';
import 'package:mabrook/utility/user_info.dart';
import 'package:mabrook/utility/utils.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utility/shared_prefs.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  late TabController controller;
  final _username           = TextEditingController();
  final _password           = TextEditingController();
  final _mobileNumber       = TextEditingController();
  List<String> voucherList  = [];

  bool _isSignInBtnWithPasswordActive = false;
  bool _isSignInBtnWithOtpActive      = false;
  bool _isGetOtpBtnWithOtpActive      = false;
  bool _passwordVisible               = false;

  bool _isSignInButtonClickable       = true;
  bool _getResendOtpButton            = true;
  bool _getOtpButton                  = true;

  final _otp = TextEditingController();


  @override
  void initState() {
    super.initState();

    controller = TabController(length: 2, initialIndex: 0, vsync: this);
    controller.addListener(() {
      if (controller.indexIsChanging || controller.index != controller.previousIndex) {
        setState(() {
          //print("set State is called");
        });
      }
    });

    _mobileNumber.addListener(() {
      //here you have the changes of your textfield
      log("value: ${_mobileNumber.text}");
      //use setState to rebuild the widget
      setState(() {
        isMobileNumberValid()
            ? _isGetOtpBtnWithOtpActive = true
            : _isGetOtpBtnWithOtpActive = false;
      });
    });

    _otp.addListener(() {
      //here you have the changes of your textfield
      log("value: ${_otp.text}");
      //use setState to rebuild the widget
      setState(() {
        isOtpValid()
            ? _isSignInBtnWithOtpActive = true
            : _isSignInBtnWithOtpActive = false;
      });
    });

    /*_username.addListener(() {
      setState(() {
        isCredentialWithPasswordValid()
          ?
            _isSignInBtnWithPasswordActive = true
          :
            _isSignInBtnWithPasswordActive = false;
      });
    });*/

    _password.addListener(() {
      setState(() {
        isCredentialWithPasswordValid()
            ? _isSignInBtnWithPasswordActive = true
            : _isSignInBtnWithPasswordActive = false;
      });
    });
  }

  @override
  bool get wantKeepAlive => false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          color: Colors.white,
          height: kToolbarHeight + 16,
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            bottom: PreferredSize(
              preferredSize: const Size(
                double.infinity,
                kToolbarHeight,
              ),
              child: TabBar(
                controller: controller,
                labelColor: Colors.white,
                isScrollable: false,
                unselectedLabelColor: Colors.black54,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                    color: Colors.lightBlue,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(7)),
                tabs: [
                  Tab(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: controller.index == 0
                                ? Colors.lightBlue
                                : Colors.grey,
                            width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(context.l10n.sign_in_with,
                              style: const TextStyle(fontSize: 12)),
                          FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                context.l10n.cap_password,
                                style: const TextStyle(fontSize: 18),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: controller.index == 1
                                ? Colors.lightBlue
                                : Colors.grey,
                            width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(context.l10n.sign_in_with,
                              style: const TextStyle(fontSize: 12)),
                          Text(
                            context.l10n.cap_otp,
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: TabBarView(controller: controller, children: [
            _signInWithPassword(),
            _signInWithOtp(),
          ]),
        )
      ]),
    );
  }

  _signInWithPassword() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _formSheetForPassword(),
          _registrationButton(),
          _signInWithPasswordButton(),
          _noteMessage(),
        ],
      ),
    );
  }

  _signInWithOtp() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _formSheetForOtp(),
          _registrationButton(),
          _signInWithOtpButton(),
          _noteMessage(),
        ],
      ),
    );
  }

  _formSheetForOtp() {
    return BlocConsumer<SignInBloc, SignInState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.enter_mobile_number,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ).pOnly(left: 30, right: 30, top: 30),
                TextField(
                  controller: _mobileNumber,
                  maxLines: 1,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, FilteringTextInputFormatter.deny(RegExp("[' ']"))],
                ).pOnly(left: 30, right: 30),
              ],
            ),
            (state is LoginOtpSentSuccessState || state is OtpLoginLoadingState) //|| state is OtpLoginErrorState
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.have_you_received_a_verification_code,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ).pOnly(left: 30, right: 30, top: 30),
                      TextField(
                          controller: _otp,
                          maxLength: 6,
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            FilteringTextInputFormatter.deny(RegExp("[' ']"))
                          ],
                        decoration: InputDecoration(
                          suffixIcon: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: _isGetOtpBtnWithOtpActive ? MaterialStateProperty.all(Colors.black) : MaterialStateProperty.all(Colors.grey),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        side: const BorderSide(
                                            color: Colors.grey
                                        )
                                    )
                                )
                            ),
                            onPressed: () {
                              if (isMobileNumberValid() && _getResendOtpButton) {
                                _getResendOtpButton = false;
                                BlocProvider.of<SignInBloc>(context).add(CheckMobileNoAvailability(mobileNumber: _mobileNumber.text, context: context));
                              }

                            },
                            child: Text(context.l10n.resend_otp,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight:
                                    FontWeight.bold
                                )
                            ),

                          ).pOnly(left: 20, bottom: 3),
                        ),
                      ).pOnly(left: 30, right: 30),
                    ],
                  )
                : Container(),
          ],
        );
      },
      listener: (context, state) {
        if (state is LoginOtpSentSuccessState) {
          _getResendOtpButton = true;
          if (state.response?.data?.mobVerificationCode != null) {
            PushNotification.show(otp: state.response?.data?.mobVerificationCode.toString() ?? "---");

          }
        } else if (state is LoginOtpSentDeniedState) {
          _getResendOtpButton = true;
          _getOtpButton       = true;
          showSnackBar(context, "You are not registered yet, please register first", Colors.red);

        } else if (state is OtpLoginSuccessState) {
          _isSignInButtonClickable = true;
          //Navigator.pushReplacementNamed(context, Screen.home_screen);
          loginSuccess();

        } else if (state is LoginOtpSentErrorState) {
          _getResendOtpButton = true;
          _getOtpButton       = true;
          showSnackBar(context, state.errorMessage, Colors.red);

        } else if (state is OtpLoginErrorState) {
          setState(() {
            _otp.clear();
          });
          _isSignInButtonClickable = true;
          _getOtpButton            = true;
          showSnackBar(context, state.errorMessage, Colors.red);

        }
      },
    );
  }

  _formSheetForPassword() {
    return BlocConsumer<SignInBloc, SignInState>(
      builder: (context, state) {
        return Wrap(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.mobile_and_email, //User Name / Email
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ).pOnly(left: 30, right: 30, top: 30),
                TextField(
                  controller: _username,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.deny(RegExp("[' ']")),
                    ]
                ).pOnly(left: 30, right: 30),
                Text(
                  context.l10n.password,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ).pOnly(left: 30, right: 30, top: 30),
                TextField(
                  controller: _password,
                  obscureText: _passwordVisible ? false : true,
                  enableSuggestions: false,
                  autocorrect: false,
                  inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.deny(RegExp("[' ']")),
                  ],
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                ).pOnly(left: 30, right: 30),
              ],
            )
          ],
        );
      },
      listener: (context, state) {
        if (state is SignInWithPasswordSuccessState) {
          _isSignInButtonClickable = true;
          loginSuccess();
        } else if (state is SignInWithPasswordErrorState) {
          _isSignInButtonClickable = true;
          showSnackBar(context, state.errorMessage, Colors.red);
        }
      },
    );
  }

  _registrationButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(context.l10n.dont_have_an_account),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlue,
                onPrimary: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                minimumSize: const Size(70, 23),
              ),
              onPressed: () {
                _cleanTextFields();
                Navigator.pushNamed(context, Screen.register_screen);
              },
              child: Text(
                context.l10n.register,
                style: const TextStyle(color: Colors.white),
              ),
            ).pOnly(left: 5),
          ],
        ).pOnly(top: 30, left: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.lightBlue,
            onPrimary: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
            minimumSize: const Size(70, 25),
          ),
          onPressed: () {
            _cleanTextFields();
            Navigator.pushNamed(context, Screen.forgot_password_screen);
          },
          child: Text(
            context.l10n.forgot_password_with_question_mark,
            style: const TextStyle(color: Colors.white),
          ),
        ).pOnly(left: 30)
      ],
    );
  }

  _signInWithPasswordButton() {
    return Padding(
        padding: const EdgeInsets.only(top: 50),
        child: BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
          return ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary:
                    _isSignInBtnWithPasswordActive ? Colors.black : Colors.grey,
                onPrimary: Colors.white,
                shadowColor: Colors.grey,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                minimumSize: const Size(300, 50),
              ),
              onPressed: () {
                if (isCredentialWithPasswordValid() && _isSignInButtonClickable) {
                  _isSignInButtonClickable = false;
                  BlocProvider.of<SignInBloc>(context).add(SignInWithPasswordCallApiEvent(_username.text, _password.text));

                }
              },
              child: Text(context.l10n.cap_sign_in,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)));
        }));
  }

  _signInWithOtpButton() {
    return Padding(
        padding: const EdgeInsets.only(top: 50),
        child: BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
          return state is LoginOtpSentSuccessState ||
                  state is OtpLoginLoadingState //|| state is OtpLoginErrorState
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: _isSignInBtnWithOtpActive ? Colors.black : Colors.grey,
                    onPrimary: Colors.white,
                    shadowColor: Colors.grey,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: const Size(300, 50),
                  ),
                  onPressed: () {
                    if (isMobileNumberValid() && isOtpValid() && _isSignInButtonClickable) {
                      _isSignInButtonClickable = false;
                      BlocProvider.of<SignInBloc>(context).add(OtpLoginCallApiEvent(_mobileNumber.text, _otp.text));
                    }
                  },
                  child: Text(context.l10n.cap_sign_in,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)))
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: _isGetOtpBtnWithOtpActive ? Colors.black : Colors.grey,
                    onPrimary: Colors.white,
                    shadowColor: Colors.grey,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: const Size(300, 50),
                  ),
                  onPressed: () {
                    if (isMobileNumberValid() && _getOtpButton) {
                      _getOtpButton = false;
                      BlocProvider.of<SignInBloc>(context).add(CheckMobileNoAvailability(mobileNumber: _mobileNumber.text, context: context));
                    }
                  },
                  child: Text(context.l10n.get_otp,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold
                      )
                  )
            );
         }
       )
     );
  }

  _noteMessage() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 20, right: 20),
      child: Text(
          context.l10n.by_signing_up_you_confirm_that_you_are_18_or_more,
          style: const TextStyle(color: Colors.black54, fontSize: 14),
          textAlign: TextAlign.center),
    );
  }

  bool isCredentialWithPasswordValid() {
    if (_username.text.isEmpty) {
      return false;
    }

    if (_password.text.isEmpty) {
      return false;
    }

    return true;
  }

  bool isMobileNumberValid() {
    if (_mobileNumber.text.isEmpty) {
      return false;
    } else if (_mobileNumber.text.length != 10) {
      return false;
    }

    return true;
  }

  bool isOtpValid() {
    if (_otp.text.isEmpty) {
      return false;
    } else if (_otp.text.length < 6) {
      return false;
    }
    return true;
  }

  _cleanTextFields() {
    _username.clear();
    _password.clear();
    _mobileNumber.clear();
    _otp.clear();
  }

  Future<void> loginSuccess() async {
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
          showSnackBar(context, response.errorMessage.toString(), Colors.red);

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

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class AlwaysEnabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => true;
}
