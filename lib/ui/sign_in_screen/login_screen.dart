import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabrook/l10n/l10n.dart';
import 'package:mabrook/ui/sign_in_screen/sign_in_bloc/sign_in_bloc.dart';
import 'package:mabrook/ui/sign_in_screen/sign_in_bloc/sign_in_state.dart';
import 'package:mabrook/ui/sign_in_screen/sign_in_screen.dart';
import 'package:mabrook/utility/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  //final _loginForm = GlobalKey<FormState>();
  TextEditingController mobileNumber = TextEditingController();
  var autoValidate = AutovalidateMode.disabled;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeightBox(40),
              Text(context.l10n.signIn,
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              /*BlocProvider<SignInBloc>(
            create: (_) => SignInBloc(),
            child: ,
          ),*/
              const SignInScreen()
            ],
          ).p(12),
          BlocBuilder<SignInBloc, SignInState>(
              builder: (context, state) {
                if (state is LoginOtpSentLoadingState || state is OtpLoginLoadingState) {
                  log("loading . . .");
                  return Container(
                    color: MabrookColor.lightTransparentGrey,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(color: Colors.black),
                          Text(context.l10n.please_wait, style: const TextStyle(
                              color: MabrookColor.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)).pOnly(top: 22)
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              })
        ],
      )
    );
  }
}
