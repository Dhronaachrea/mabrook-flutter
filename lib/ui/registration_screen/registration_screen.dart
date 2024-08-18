import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mabrook/l10n/l10n.dart';
import 'package:mabrook/models/request/otp_model.dart';
import 'package:mabrook/ui/registration_screen/registration_bloc/registration_bloc.dart';
import 'package:mabrook/ui/registration_screen/registration_bloc/registration_event.dart';
import 'package:mabrook/ui/registration_screen/registration_bloc/registration_state.dart';
import 'package:mabrook/utility/colors.dart';
import 'package:mabrook/utility/notification.dart';
import 'package:mabrook/utility/screens.dart';
import 'package:mabrook/utility/utils.dart';
import 'package:velocity_x/velocity_x.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _userName         = TextEditingController();
  final _mobileNumber     = TextEditingController();
  final _email            = TextEditingController();
  final _dateOfBirth      = TextEditingController();
  final _password         = TextEditingController();
  bool isLoading          = false;
  bool _passwordVisible   = false;

  bool _isSubmitButtonClickable = true;

  late DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          if (state is RegisterLoadingState) {
            isLoading = true;

          } else if (state is RegisterSuccessState) {
            log("Success");
            OtpModel otpModel = OtpModel(
              mobileNo: _mobileNumber.text,
              otp: state.response.data?.mobVerificationCode??"",
              password: _password.text,
              dob: _dateOfBirth.text,
              email: _email.text,
              firstName: _userName.text,
            );
            _isSubmitButtonClickable = true;
            PushNotification.show(otp: otpModel.otp);
            Navigator.pushReplacementNamed(context, Screen.otp_screen,arguments: otpModel);

          } else if (state is RegisterErrorState) {
            log("Error");
            _isSubmitButtonClickable = true;
            isLoading = false;

            if (state.errorCode != 10302) {
              Navigator.pop(context);
            }
            showSnackBar(context, state.errorMessage.toString(), Colors.red);
          }
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
                    _submitButton(),
                    _noteMessage()
                  ],
                ),
              ),
            ),
          ),
        ),
          BlocBuilder<RegistrationBloc, RegistrationState>(
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

              })

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
          Text(context.l10n.welcome, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),

          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              context.l10n.name,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextField(
            controller: _userName,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.deny(RegExp("[' ']")),
            ]
          ),

          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              context.l10n.mobile_number,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextField(
            controller: _mobileNumber,
            maxLines: 1,
            maxLength: 10,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly, FilteringTextInputFormatter.deny(RegExp("[' ']"))]

          ),

          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              context.l10n.email_address,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextField(
            controller: _email,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.deny(RegExp("[' ']")),
            ],
            decoration: const InputDecoration(
              hintText: "customer@gmail.com",
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              context.l10n.date_of_birth,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextField(
            controller: _dateOfBirth,
            focusNode: AlwaysDisabledFocusNode(),
            decoration: const InputDecoration(
              hintText: "YY MM DD",
            ),
            onTap: () => _selectDate(context),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              context.l10n.password,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextField(
            controller: _password,
            obscureText: _passwordVisible? false : true,
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
          ),
        ],
      ),
    );
  }

  _submitButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          onPrimary: Colors.white,
          shadowColor: Colors.greenAccent,
          elevation: 3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0)
          ),
          minimumSize: const Size(300, 50),
        ),
        onPressed: () {
            if (isValidate() && _isSubmitButtonClickable) {
              _isSubmitButtonClickable = false;
              BlocProvider.of<RegistrationBloc>(context).add(RegisterCheckMobileNoAvailabilityEvent(context, _userName.text, _mobileNumber.text, _dateOfBirth.text, _email.text, _password.text));

            } else {
              log("fill required fields");
          }
        },
        child: Text(context.l10n.cap_sing_up, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      ),
    );
  }

  _noteMessage() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 20, right: 20),
      child: Text(context.l10n.by_signing_up_you_confirm_that_you_are_18_or_more,
      style: const TextStyle(color: Colors.black54, fontSize: 14 ),textAlign: TextAlign.center),
    );
  }

  _selectDate(BuildContext context) async {
    var todayDate = DateTime.now();
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime(todayDate.year-18,todayDate.month, todayDate.day),
        firstDate: DateTime(1960),
        lastDate: DateTime(todayDate.year-18,todayDate.month, todayDate.day),
        );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _dateOfBirth
        ..text = DateFormat('yyyy-MM-dd').format(_selectedDate)
        ..selection = TextSelection.fromPosition(
            TextPosition(
            offset: _dateOfBirth.text.length,
            affinity: TextAffinity.upstream
            )
        );
    }
  }

  bool isValidate() {
    if (_userName.text.isEmpty) {
        showSnackBar(context, "Please Enter your name", Colors.red);
        return false;

    } /*if (_mobileNumber.text.isNotEmpty) {
        if (!_mobileNumber.text.isValidMobile()) {
          showSnackBar(context, "Please Enter valid mobile number", Colors.red);
          return false;
        }
    }*/

    if (_mobileNumber.text.isEmpty) {
      showSnackBar(context, "Please Enter Mobile No.", Colors.red);
      return false;
    }
    else if(_mobileNumber.text.length != 10) {
      showSnackBar(context, "Please Enter valid Mobile No.", Colors.red);
      return false;
    }

    if (_email.text.isNotEmpty) {
      if (!_email.text.isValidEmail()) {
        showSnackBar(context, "Please Enter valid email", Colors.red);
        return false;
      }
    }

    if(_email.text.isEmpty) {
      showSnackBar(context, "Please Enter email address", Colors.red);
      return false;
    }

    if (_dateOfBirth.text.isEmpty) {
        showSnackBar(context, "Please Enter Date of Birth", Colors.red);
        return false;
    }

    if (_password.text.isNotEmpty) {
        if (!_password.text.isValidPassword()) {
          showSnackBar(context, "At least 1 number and 1 alphabet should be there and range should be 8-16 digits.", Colors.red);
          return false;
        }
    }

    if(_password.text.isEmpty) {
      showSnackBar(context, "Please Enter password", Colors.red);
      return false;
    }

    return true;
  }

}
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
