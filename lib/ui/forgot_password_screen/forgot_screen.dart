import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabrook/l10n/l10n.dart';
import 'package:mabrook/models/request/rest_password_model.dart';
import 'package:mabrook/ui/forgot_password_screen/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:mabrook/utility/colors.dart';
import 'package:mabrook/utility/screens.dart';
import 'package:mabrook/utility/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _mobileNumber             = TextEditingController();
  bool _isSignInBtnActive         = false;
  bool isLoading                  = false;
  bool _isResetButtonClickAble    = true;

  @override
  void initState() {
    super.initState();

    _mobileNumber.addListener(() {
      setState(() {
        isValidate() ? _isSignInBtnActive = true : _isSignInBtnActive = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _mobileNumber.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white54,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      _formSheet(),
                      _submitButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),

          BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
              builder: (context, state) {
                if (state is ForgotPasswordLoadingState) {
                  log("loading");
                  return Container(
                    color: MabrookColor.lightTransparentGrey,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(color: Colors.black),
                          Text(
                              context.l10n.please_wait,
                              style: const TextStyle(
                                  color: MabrookColor.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold
                              )
                          ).pOnly(top: 22)
                        ],
                      ),
                    ),
                  );
                }
                return Container();

              })

        ],
      ),
    );
  }

  _formSheet() {
    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Image.asset(
                'assets/icons/back.png',
                color: Colors.black,
                width: 30,
                height: 30,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              context.l10n.forgot_password,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
                context.l10n.please_enter_the_mobile_number_you_like_your_password_reset,
                style: const TextStyle(color: Colors.black, fontSize: 14),
                textAlign: TextAlign.start),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                context.l10n.mobile,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextField(
              controller: _mobileNumber,
              maxLength: 10,
              maxLines: 1,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly, FilteringTextInputFormatter.deny(RegExp("[' ']"))],

            ),
          ],
        );
      },
      listener: (context, state) {
        if (state is ForgotPasswordLoadingState) {

        } else if (state is ForgotPasswordSuccessState) {
          ResetPasswordModel otpModel = ResetPasswordModel(
            mobileNo: _mobileNumber.text.toString(),
          );

          _isResetButtonClickAble = true;
          Navigator.pushNamed(context, Screen.rest_password_Screen, arguments: otpModel);
          showSnackBar(context,state.response.respMsg.toString(), Colors.green);

        } else if (state is ForgotPasswordErrorState) {
          _isResetButtonClickAble = true;
          showSnackBar(context,state.errorMessage, Colors.red);
        }
      },
    );
  }

  _submitButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: _isSignInBtnActive ? Colors.black : Colors.grey,
          onPrimary: Colors.white,
          shadowColor: Colors.greenAccent,
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
          minimumSize: const Size(300, 50),
        ),
        onPressed: () {
          if (isValidate() && _isResetButtonClickAble) {
            _isResetButtonClickAble = false;
            BlocProvider.of<ForgotPasswordBloc>(context).add(ForgotPasswordCallApiEvent(_mobileNumber.text));

          }
        },
        child: Text(
          context.l10n.reset,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  bool isValidate() {
    if (_mobileNumber.text.isEmpty) {
      return false;
    }
    else if(_mobileNumber.text.length != 10) {
      return false;
    }
    return true;

  }

}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
