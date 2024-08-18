import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mabrook/l10n/l10n.dart';
import 'package:mabrook/ui/profile_edit_screen/profile_edit_bloc/profile__edit_state.dart';
import 'package:mabrook/ui/profile_edit_screen/profile_edit_bloc/profile_edit_bloc.dart';
import 'package:mabrook/ui/profile_edit_screen/profile_edit_bloc/profile_edit_event.dart';
import 'package:mabrook/utility/colors.dart';
import 'package:mabrook/utility/user_info.dart';
import 'package:mabrook/utility/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileEditScreen extends StatefulWidget {

  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> with RouteAware {
  final _firstName      = TextEditingController();
  final _lastName       = TextEditingController();
  final _dateOfBirth    = TextEditingController();
  final _email          = TextEditingController();
  bool _isUpdateActive  = false;
  bool _isUpdateButtonClickAble  = true;
  //final _nationality  = TextEditingController();

  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();

    setDefaultValues();

    _firstName.addListener(() {
      setState(() {
        isUpdateBtnEnabled()
            ?
        _isUpdateActive = true
            :
        _isUpdateActive = false;
      });
    });

    _lastName.addListener(() {
      setState(() {
        isUpdateBtnEnabled()
            ?
        _isUpdateActive = true
            :
        _isUpdateActive = false;
      });
    });

    _dateOfBirth.addListener(() {
      setState(() {
        isUpdateBtnEnabled()
            ?
        _isUpdateActive = true
            :
        _isUpdateActive = false;
      });
    });

    _email.addListener(() {
      setState(() {
        isUpdateBtnEnabled()
            ?
        _isUpdateActive = true
            :
        _isUpdateActive = false;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: BlocConsumer<ProfileEditBloc, ProfileEditState>(
                builder: (context, state) {
                  return Container(
                    color: Colors.white54,
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        children: [_formSheet(), _submitButton()],
                      ),
                    ),
                  );
                },
                listener: (context, state) {
                  if (state is PlayerEditProfileErrorState) {
                    _isUpdateButtonClickAble = true;
                    showSnackBar(context, state.errorMessage, Colors.red);

                  }
                },
              ),
            ),
          ),
          BlocBuilder<ProfileEditBloc, ProfileEditState>(
              builder: (context, state) {
            if (state is PlayerEditProfileLoadingState) {
              log("loading . . .");
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
          })
        ],
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
            context.l10n.edit_your_profile,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              context.l10n.first_name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextField(
            controller: _firstName,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.deny(RegExp("[' ']")),
            ],
            decoration: InputDecoration.collapsed(
              hintText: UserInfo.firstname.isNotEmpty ? UserInfo.firstname : context.l10n.first_name,
              hintStyle: const TextStyle(color: MabrookColor.fadedBlack),
            ),
          ).pOnly(top: 8),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              context.l10n.last_name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextField(
            controller: _lastName,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.deny(RegExp("[' ']")),
            ],
            decoration: InputDecoration.collapsed(
              hintText: UserInfo.lastname.isNotEmpty ? UserInfo.lastname : context.l10n.last_name,
              hintStyle: const TextStyle(color: MabrookColor.fadedBlack),
            ),
          ).pOnly(top: 8),

          /*const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Text(
              "Nationality",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),*/

          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              context.l10n.date_of_birth,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextField(
            controller: _dateOfBirth,
            focusNode: AlwaysDisabledFocusNode(),
            decoration: InputDecoration(
              hintText: UserInfo.dob.isNotEmpty ? UserInfo.dob : context.l10n.yy_mm_dd,
              hintStyle: const TextStyle(color: MabrookColor.fadedBlack),
            ),
            onTap: () => _selectDate(context),
          ),
          UserInfo.isEmailVerified()
          ?
              Container()
          :
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.email_address,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ).pOnly(top: 30),
              TextField(
                controller: _email,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.deny(RegExp("[' ']")),
                ],
                decoration: InputDecoration(
                  hintText: UserInfo.emailId,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _submitButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: _isUpdateActive ? Colors.black : Colors.grey,
          onPrimary: Colors.white,
          shadowColor: Colors.grey,
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
          minimumSize: const Size(300, 50),
        ),
        onPressed: () {
          if (_isUpdateActive && _isUpdateButtonClickAble) {
            _isUpdateButtonClickAble = false;
            BlocProvider.of<ProfileEditBloc>(context).add(
                ProfileEditApiCallEvent(context, _firstName.text.toString().isNotEmpty ? _firstName.text.toString() : UserInfo.firstname,
                    _lastName.text.toString().isNotEmpty ? _lastName.text.toString() : UserInfo.lastname,
                    _dateOfBirth.text.toString().isNotEmpty ? _dateOfBirth.text.toString() : getYYYYMMddDob(UserInfo.dob.split(" ")[0]),
                _email.text));
          }

        },
        child: Text(
          context.l10n.cap_update,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    var todayDate = DateTime.now();
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate:
          DateTime(todayDate.year - 18, todayDate.month, todayDate.day),
      firstDate: DateTime(1960),
      lastDate: DateTime(todayDate.year - 18, todayDate.month, todayDate.day),
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _dateOfBirth
        ..text = DateFormat('yyyy-MM-dd').format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _dateOfBirth.text.length, affinity: TextAffinity.upstream));
    }
  }

  bool isValidate() {
    if (_firstName.text.isEmpty) {
      showSnackBar(context, "Please provide your firstname", Colors.red);
      return false;
    }

    if (_lastName.text.isEmpty) {
      showSnackBar(context, "Please provide your lastname", Colors.red);
      return false;
    }

    if (_dateOfBirth.text.isEmpty) {
      showSnackBar(context, "Please provide date of birth", Colors.red);
      return false;
    }

    return true;
  }

  bool isUpdateBtnEnabled() {
    if (_firstName.text.isNotEmpty || _lastName.text.isNotEmpty || _dateOfBirth.text.isNotEmpty || _email.text.isValidEmail()) {
      return true;
    }

    return false;
  }

  setDefaultValues() {
    _email.text         = UserInfo.emailId;
    _firstName.text     = UserInfo.firstname;
    if (UserInfo.lastname.isNotEmpty) {
      _lastName.text    = UserInfo.lastname;
    }
    _dateOfBirth.text   = DateFormat("yyyy-MM-dd").format(DateFormat('dd/MM/yyyy').parse(UserInfo.dob));
  }

}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
