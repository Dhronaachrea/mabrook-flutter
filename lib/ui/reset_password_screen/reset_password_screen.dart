import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabrook/l10n/l10n.dart';
import 'package:mabrook/models/request/rest_password_model.dart';
import 'package:mabrook/ui/reset_password_screen/reset_password_bloc/reset_password_bloc.dart';
import 'package:mabrook/utility/colors.dart';
import 'package:mabrook/utility/utils.dart';
import 'package:velocity_x/velocity_x.dart';


class RestPasswordScreen extends StatefulWidget {
  final ResetPasswordModel model;

  const RestPasswordScreen({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<RestPasswordScreen> createState() => _RestPasswordScreenState();
}

class _RestPasswordScreenState extends State<RestPasswordScreen> {
  final _oneTimePassword          = TextEditingController();
  final _password                 = TextEditingController();
  final _confirmPassword          = TextEditingController();
  bool isLoading                  = false;
  bool _isPasswordMatched         = false;
  bool _isConfirmPasswordMatched  = false;
  bool _isOtpEntered              = false;
  bool _passwordVisible           = false;
  bool _confirmPasswordVisible    = false;
  bool _isSubmitbuttonClickAble   = true;


  @override
  void initState() {
    super.initState();

    _oneTimePassword.addListener(() {
      setState(() {
        if (_oneTimePassword.text.length <= 5) {
          _isOtpEntered = false;
        } else {
          _isOtpEntered = true;
        }
      });
    });

    _password.addListener(() {
      setState(() {
        if (_password.text.length < 8) {
          _isPasswordMatched = false;
        } else {
          _isPasswordMatched = true;
        }
      });
    });
    _confirmPassword.addListener(() {
      setState(() {
        if (_confirmPassword.text.length < 8) {
          _isConfirmPasswordMatched = false;
        } else {
          _isConfirmPasswordMatched = true;
        }
      });
    });
  }

  @override
  void dispose() {
    _oneTimePassword.clear();
    _password.clear();
    _confirmPassword.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
                        _buttons(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
                builder: (context, state) {
              if (state is ResetPasswordLoadingState) {
                log("loading");
                return Container(
                  color: MabrookColor.lightTransparentGrey,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircularProgressIndicator(color: Colors.black),
                        Text(context.l10n.please_wait,
                                style: const TextStyle(
                                    color: MabrookColor.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold))
                            .pOnly(top: 22)
                      ],
                    ),
                  ),
                );
              }

              return Container();
            },
            listener: (context, state) {

              if (state is ResetPasswordSuccessState) {
                var nav = Navigator.of(context);
                nav.pop();
                nav.pop();
                showSnackBar(context, state.response.respMsg.toString(), Colors.green);

              } else if (state is ResetPasswordErrorState) {
                _isSubmitbuttonClickAble = true;
              showSnackBar(context, state.errorMessage, Colors.red);

              }
            },

            )
          ],
        ),
      ),
    );
  }

  _formSheet() {
    return Padding(
      padding: const EdgeInsets.only(top: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.reset_password,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              context.l10n.one_time_password,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextField(
            controller: _oneTimePassword,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly, FilteringTextInputFormatter.deny(RegExp("[' ']"))],
          ),
          Text(
            context.l10n.password,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ).pOnly(top: 30),
          TextField(
            controller: _password,
            obscureText: _passwordVisible? false : true,
            enableSuggestions: false,
            autocorrect: false,
            inputFormatters: [ FilteringTextInputFormatter.deny(RegExp("[' ']"))],
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
          ),
          Text(
            context.l10n.confirm_password,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ).pOnly(top: 30),
          TextField(
            controller: _confirmPassword,
            obscureText: _confirmPasswordVisible? false : true,
            enableSuggestions: false,
            autocorrect: false,
            inputFormatters: [FilteringTextInputFormatter.deny(RegExp("[' ']"))],
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  _confirmPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    _confirmPasswordVisible = !_confirmPasswordVisible;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buttons() {
    return Row(
      children: [
        ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.only(
                      top: 10, left: 30, right: 30, bottom: 10)),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(width: 1, color: Colors.black)))),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            context.l10n.cap_cancel,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(child: Container()),
        ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.only(
                      top: 10, left: 30, right: 30, bottom: 10)),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor:( _isPasswordMatched &&
                      _isConfirmPasswordMatched &&
                      _isOtpEntered &&
                      _password.text.toString() == _confirmPassword.text.toString())
                  ?
                      MaterialStateProperty.all<Color>(Colors.black)
                  :
                      MaterialStateProperty.all<Color>(Colors.grey),

              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.black)))),
          onPressed: () {
            if (_isPasswordMatched &&
                _isConfirmPasswordMatched &&
                _isOtpEntered &&
                _password.text.toString() == _confirmPassword.text.toString() && _isSubmitbuttonClickAble) {

              _isSubmitbuttonClickAble = false;

              BlocProvider.of<ResetPasswordBloc>(context).add(
                  ResetPasswordCallApiEvent(
                      _oneTimePassword.text.toString(),
                      _password.text.toString(),
                      _confirmPassword.text.toString(),
                      widget.model.mobileNo
                  )
              );
            }
          },
          child: Text(
            context.l10n.cap_submit,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ).pOnly(left: 15, right: 15, top: 20);
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
