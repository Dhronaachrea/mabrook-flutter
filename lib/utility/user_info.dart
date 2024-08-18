import 'dart:convert';

import 'package:mabrook/flavor_config.dart';
import 'package:mabrook/utility/shared_prefs.dart';

class UserInfo {
  static final UserInfo _instance = UserInfo._ctor();

  factory UserInfo() {
    return _instance;
  }

  UserInfo._ctor();

  static setPlayerToken(String token) {
    print("before:--------------->${SharedPrefUtils.playerToken}");
    SharedPrefUtils.playerToken = token;
    print("after:--------------->${SharedPrefUtils.playerToken}");
  }

  static setMobileNo(String mobileNo) {
    SharedPrefUtils.mobileNo = mobileNo;
  }

  static setPlayerCountryCode(String countryCode) {
    SharedPrefUtils.countryCode = countryCode;
  }

  static setPlayerProfileImage(String profileImage) {
    SharedPrefUtils.profileImage = profileImage;
  }

  static setPlayerFirstname(String firstname) {
    SharedPrefUtils.firstname = firstname;
  }

  static setPlayerLastname(String lastname) {
    SharedPrefUtils.lastname = lastname;
  }

  static setPlayerDob(String dob) {
    SharedPrefUtils.dob = dob;
  }

  static setPlayerEmailId(String email) {
    SharedPrefUtils.emailId = email;
  }

  static setPlayerEmailVerified(String emailVerified) {
    SharedPrefUtils.emailVerified = emailVerified;
  }

  static setPlayerId(int playerId) {
    SharedPrefUtils.playerId = playerId;
  }

  static setUserName(String userName) {
    SharedPrefUtils.userName = userName;
  }

  static setConfigData(String configData) {
    SharedPrefUtils.configData = configData;
  }

  /*static setPlayerInfo(String playerInfo) {
    SharedPrefUtils.playerInfo = playerInfo;
  }*/

  static bool isLoggedIn() {
    return SharedPrefUtils.playerToken != '';
  }

  static bool isEmailVerified() {
    return UserInfo.emailVerified == 'Y';
  }

  static logout() {
    SharedPrefUtils.removeValue(PrefType.USER_PREF.value);
  }

  static String get userToken               => SharedPrefUtils.playerToken;
  static int get userId                     => SharedPrefUtils.playerId;
  static String get userName                => SharedPrefUtils.userName;
  static String get mobileNo                => SharedPrefUtils.mobileNo;
  static String get emailVerified           => SharedPrefUtils.emailVerified;
  static String get firstname               => SharedPrefUtils.firstname;
  static String get profileImage            => SharedPrefUtils.profileImage;
  static String get countryCode             => SharedPrefUtils.countryCode;
  static String get lastname                => SharedPrefUtils.lastname;
  static String get dob                     => SharedPrefUtils.dob;
  static String get emailId                 => SharedPrefUtils.emailId;
  static String get configData              => SharedPrefUtils.configData;
  static FlavorConfig get decodedMap        => FlavorConfig.fromJson(jsonDecode(UserInfo.configData));

  //static String get playerInfo              => SharedPrefUtils.playerInfo;
  //static PlayerInfoBean get playerResponse  => PlayerInfoBean.fromJson(jsonDecode(playerInfo));

}
