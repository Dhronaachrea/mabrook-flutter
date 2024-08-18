import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';
import 'package:mabrook/dialogs/confirm_dialog.dart';
import 'package:mabrook/utility/app_constant.dart';
import 'package:mabrook/utility/auth_bloc/auth_bloc.dart';
import 'package:mabrook/utility/response_code.dart';
import 'package:mabrook/utility/screens.dart';
import 'package:mabrook/utility/user_info.dart';
import 'package:package_info_plus/package_info_plus.dart';

final navigatorKey = GlobalKey<NavigatorState>();

printRequestAndResponse(Response response, request, header) {
  log("Request:     --> ${response.request}");
  log("RequestBody: --> $request");
  log("Header:      --> $header");
  log("Response:    <-- ${response.body}");

}

printMultipartRequestAndResponse(String response, String request, header) {

  log("Request:     --> $request");
  log("Header:      --> $header");
  log("Response:    <-- $response");

}

enum FileTypeOptions {
  gallery,
  camera,
}

extension StringExt on String {
  bool isValidEmail() {
    return RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+[.]+[a-zA-Z]+$')
        .hasMatch(this);
  }

  bool isValidMobile() {
    // return RegExp(r'^[7,1]{1}[0-9]{9}$').hasMatch(this);
    return RegExp(r'^((\+){1}966){1}[1-9]{1}[0-9]{6,9}$').hasMatch(this);
  }

  bool isValidPassword() {
    //final pwd = RegExp(r'^[a-zA-Z0-9^:!@#().+?,_$*&%]*$');
    //final pwd = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');
    //final pwd = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*()])\S{8,16}$');
    final pwd = RegExp(r'^(?=.*[A-z])(?=.*[0-9])\S{8,16}$');
    return pwd.hasMatch(this);
  }
}

String getDateFromTimeStamp(dynamic timeStamp) {
  try {
    var date = DateTime.fromMillisecondsSinceEpoch(timeStamp);//timeStamp = 1630506255982
    return DateFormat('dd MMM').format(date);
  } catch (e) {
    return timeStamp.toString();
  }
}

String getFormattedOnlyDate(String date) { // for QA
  try {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    var inputDate = inputFormat.parse(date);
    return DateFormat("dd MMM").format(inputDate);

  } catch (e) {
    log("Exception: $e");
    return date.toString();
  }
}

String getDayDateTimeFromTimeStamp(dynamic timeStamp) {
  try {
    var date = DateTime.fromMillisecondsSinceEpoch(timeStamp);//timeStamp = 1630506255982
    return DateFormat('EEE, dd MMM yyyy').format(date);
  } catch (e) {
    return timeStamp.toString();
  }
}

String getFormattedDayDateTime(String date) { // for QA
  try {
    
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    var inputDate = inputFormat.parse(date);
    return DateFormat("EEE, dd MMM yyyy").format(inputDate);

  } catch (e) {
    log("Exception: $e");
    return date.toString();
  }
}

String getTimeFromTimeStamp(dynamic timeStamp) {
  try {
    var date = DateTime.fromMillisecondsSinceEpoch(timeStamp);//timeStamp = 1630506255982
    return DateFormat('HH:mm a, EEE').format(date);
  } catch (e) {
    return timeStamp.toString();
  }
}

String getFormattedOnlyTime(String date) { // for QA
  try {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    var inputDate = inputFormat.parse(date);
    return DateFormat("HH:mm a, EEE").format(inputDate);

  } catch (e) {
    log("Exception: $e");
    return date.toString();
  }
}

String getValidTillTimeStamp(dynamic timeStamp) {
  try {
    var date = DateTime.fromMillisecondsSinceEpoch(timeStamp);//timeStamp = 1630506255982
    return DateFormat('HH:mm a-EEE, dd MMM yyyy').format(date);
  } catch (e) {
    return timeStamp.toString();
  }
}

String getFormattedValidTillDate(String date) { // for QA
  try {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    var inputDate = inputFormat.parse(date);
    return DateFormat("HH:mm a-EEE, dd MMM yyyy").format(inputDate);

  } catch (e) {
    log("Exception: $e");
    return date.toString();
  }
}

String getFormattedDob(String date) {
  try {
    var splitDate = date.toString().split("/")[1];

    var inputFormat = DateFormat('dd/MM/yyyy');
    var inputDate = inputFormat.parse(date); // <-- dd/MM 24H format

    switch (int.parse(splitDate)) {
      case 1:
        return DateFormat("MM dd'st', yyyy").format(inputDate);
      case 2:
        return DateFormat("MM dd'nd', yyyy").format(inputDate);
      case 3:
        return DateFormat("MMM dd'rd', yyyy").format(inputDate);
      default:
        return DateFormat("MMMM dd'th', yyyy").format(inputDate);
    }
  } catch (e) {
    log("Exception: $e");
    return date.toString();
  }
}

String getFormattedDate (String date) {
  const String pattern = 'dd MMM, yyyy';
  final String formatted = DateFormat(pattern).format(DateTime.parse(date));
  log(formatted);
  return formatted;
}

showUserConfirmationDialog(String message, String positiveBtnText, String negativeBtnText, bool isForSessionExpiry) async {
  BuildContext context = navigatorKey.currentContext!;
  var response = await ConfirmDialog.show(
    context             : context,
    message             : message,
    negativeButtonText  : negativeBtnText,
    positiveButtonText  : positiveBtnText,
  );

  if ((response != null) && (response == false)) {
    UserInfo.logout();
    Navigator.of(context).pushNamedAndRemoveUntil(
        Screen.login_screen,
            (route) => false);

    BlocProvider.of<AuthBloc>(context).add(UserLogout());
  }

  /*if (response == true) {
    if (isForSessionExpiry) {
      Navigator.pushReplacementNamed(context, Screen.login_screen);
    }
  } else {
    UserInfo.logout();
    Navigator.of(context).pushNamedAndRemoveUntil(
        Screen.login_screen,
            (route) => false);
    BlocProvider.of<AuthBloc>(context).add(
      UserLogout(),
    );
  }*/
}

showSnackBar(BuildContext context, String message, Color inputColor) {
  Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    message: message,
    duration: const Duration(seconds: 3),
    backgroundColor: inputColor,
  ).show(context);
}

encryptMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

String errorCodeMapper(serverType,errorCode){
  String mappedMessage = "";

  if (serverType == AppConstants.RAM) {
    mappedMessage =  ResponseCode.ramErrorCode["${serverType}_$errorCode"] ?? "";

  } else if (serverType == AppConstants.VMS) {
    mappedMessage =  ResponseCode.vmsErrorCode["${serverType}_$errorCode"] ?? "";

  } else if (serverType == AppConstants.DMS) {
    mappedMessage =  ResponseCode.dmsErrorCode["${serverType}_$errorCode"] ?? "";

  } else if (serverType == AppConstants.WEAVER) {
    mappedMessage =  ResponseCode.weaverErrorCode["${serverType}_$errorCode"] ?? "";

  }

  if (mappedMessage.isNotEmpty) {
    return mappedMessage;

  } else {
    return "Unable to fetch information, please try again later![$serverType - $errorCode]";

  }

}

formatDate({
  required String date,
  required String inputFormat,
  required String outputFormat,
}) {
  DateFormat inputDateFormat = DateFormat(inputFormat);
  DateTime input = inputDateFormat.parse(date);
  DateFormat outputDateFormat = DateFormat(outputFormat);
  return outputDateFormat.format(input);
}

String getYYYYMMddDob(String date) {
  try {

    var inputFormat = DateFormat('dd/MM/yyyy');
    var inputDate = inputFormat.parse(date);
    return DateFormat("yyyy-MM-dd").format(inputDate);

  } catch (e) {
    log("Exception: $e");
    return date.toString();
  }
}

getVersion() async{
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;

  // ignore: unused_local_variable
  var appVersion = '$version+$buildNumber';

  return version;
}

checkNetworkConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print("Connected");
      return true;
    }
  } on Exception catch (e) {
    print("Not Connected ");
    return false;
  } catch (e) {
    print("Not Connected 2");
    return false;
  }
}
