import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils {
  static const _APP_PREF = "APP_PREF";
  static final _USER_PREF = "USER_PREF";

  //APP DATA
  static const _VOUCHER_DATA = "voucherData";

  static const _PLAYER_TOKEN = "playerToken";
  static const _PLAYER_ID = "playerId";
  static const _PLAYER_USER_NAME = "userName";
  static const _PLAYER_MOBILE_NO = "mobileNo";
  static const _PLAYER_COUNTRY_CODE = "countryCode";
  static const _PLAYER_FIRSTNAME = "firstname";
  static const _PLAYER_LASTNAME = "lastname";
  static const _PLAYER_DOB = "dob";
  static const _CONFIG_DATA               = "configData";
  static const _PLAYER_EMAIL_ID = "emailId";
  static const _PLAYER_EMAIL_VERIFIED = "emailVerified";
  static const _LOGIN_RESPONSE = "loginResponse";
  static const _PROFILE_IMAGE = "profileImage";
  static const _PLAYER_INFO = "playerInfo";

  static final SharedPrefUtils _instance = SharedPrefUtils._ctor();

  factory SharedPrefUtils() {
    return _instance;
  }

  SharedPrefUtils._ctor();

  static late SharedPreferences _prefs;

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // APP_DATA functions

  static setAppStringValue(String key, String value) {
    final String? storedData =
        _prefs.containsKey(_APP_PREF) ? _prefs.getString(_APP_PREF)! : null;
    Map newData = {key: value};
    Map newDataMap = {};

    if (storedData != null) {
      newDataMap.addAll(jsonDecode(storedData));
      newDataMap.addAll(newData);
    } else {
      newDataMap = newData;
    }

    _prefs.setString(_APP_PREF, jsonEncode(newDataMap));
  }

  static String getAppStringValue(String key) {
    Map<String, dynamic> allPrefs = _prefs.getString(_APP_PREF) != null
        ? jsonDecode(_prefs.getString(_APP_PREF) ?? '')
        : {};

    return allPrefs[key] ?? '';
  }

  static Map<String, dynamic> getAllAppPrefs() {
    Map<String, dynamic> allPrefs = _prefs.containsKey(_APP_PREF)
        ? jsonDecode(_prefs.getString(_APP_PREF)!)
        : {};
    return allPrefs;
  }

  // USER_DATA functions

  static setUserStringValue(String key, String value) {
    final String? storedData =
        _prefs.containsKey(_USER_PREF) ? _prefs.getString(_USER_PREF) : null;
    Map newData = {key: value};
    Map newDataMap = {};

    if (storedData != null) {
      newDataMap.addAll(jsonDecode(storedData));
      newDataMap.addAll(newData);
    } else {
      newDataMap = newData;
    }

    _prefs.setString(_USER_PREF, jsonEncode(newDataMap));
  }

  static setUserIntValue(String key, int value) {
    final String? storedData =
        _prefs.containsKey(_USER_PREF) ? _prefs.getString(_USER_PREF) : null;
    Map newData = {key: value};
    Map newDataMap = {};

    if (storedData != null) {
      newDataMap.addAll(jsonDecode(storedData));
      newDataMap.addAll(newData);
    } else {
      newDataMap = newData;
    }

    _prefs.setString(_USER_PREF, jsonEncode(newDataMap));
  }

  static String getUserStringValue(String key) {
    Map<String, dynamic> allPrefs = _prefs.getString(_USER_PREF) != null
        ? jsonDecode(_prefs.getString(_USER_PREF) ?? '')
        : {};
    return allPrefs[key] ?? '';
  }

  static int getUserIntValue(String key) {
    Map<String, dynamic> allPrefs = _prefs.getString(_USER_PREF) != null
        ? jsonDecode(_prefs.getString(_USER_PREF) ?? '')
        : {};
    return allPrefs[key] ?? '';
  }

  static Map<String, dynamic> getAllUserPrefs() {
    Map<String, dynamic> allPrefs = _prefs.containsKey(_USER_PREF)
        ? jsonDecode(_prefs.getString(_USER_PREF)!)
        : {};
    return allPrefs;
  }

  static removeValue(String key) {
    return _prefs.remove(key);
  }

  static String get playerToken             => getUserStringValue(_PLAYER_TOKEN);
  static int get playerId                   => getUserIntValue(_PLAYER_ID);
  static String get userName                => getUserStringValue(_PLAYER_USER_NAME);
  static String get mobileNo                => getUserStringValue(_PLAYER_MOBILE_NO);
  static String get countryCode             => getUserStringValue(_PLAYER_COUNTRY_CODE);
  static String get firstname               => getUserStringValue(_PLAYER_FIRSTNAME);
  static String get lastname                => getUserStringValue(_PLAYER_LASTNAME);
  static String get dob                     => getUserStringValue(_PLAYER_DOB);
  static String get emailId                 => getUserStringValue(_PLAYER_EMAIL_ID);
  static String get emailVerified           => getUserStringValue(_PLAYER_EMAIL_VERIFIED);
  static String get profileImage            => getUserStringValue(_PROFILE_IMAGE);
  static String get configData              => getAppStringValue(_CONFIG_DATA);
  static String get voucherData             => getAppStringValue(_VOUCHER_DATA);
  static String get playerInfo              => getAppStringValue(_PLAYER_INFO);

  static set playerToken(String value)      => setUserStringValue(_PLAYER_TOKEN, value);

  static set playerId(int value)            => setUserIntValue(_PLAYER_ID, value);

  static set userName(String value)         => setUserStringValue(_PLAYER_USER_NAME, value);

  static set mobileNo(String value)         => setUserStringValue(_PLAYER_MOBILE_NO, value);

  static set firstname(String value)        => setUserStringValue(_PLAYER_FIRSTNAME, value);

  static set lastname(String value)         => setUserStringValue(_PLAYER_LASTNAME, value);

  static set dob(String value)              => setUserStringValue(_PLAYER_DOB, value);

  static set emailId(String value)          => setUserStringValue(_PLAYER_EMAIL_ID, value);

  static set emailVerified(String value)    => setUserStringValue(_PLAYER_EMAIL_VERIFIED, value);

  static set countryCode(String value)      => setUserStringValue(_PLAYER_COUNTRY_CODE, value);

  static set loginResponse(String value)    => setUserStringValue(_LOGIN_RESPONSE, value);

  static set profileImage(String value)     => setUserStringValue(_PROFILE_IMAGE, value);

  static set configData(String value)       => setAppStringValue(_CONFIG_DATA, value);

  static set playerInfo(String value) => setAppStringValue(_PLAYER_INFO, value);

  static set voucherData(String value) => setAppStringValue(_VOUCHER_DATA, value);
}

enum PrefType { APP_PREF, USER_PREF }

extension PrefExtension on PrefType {
  String get value {
    switch (this) {
      case PrefType.APP_PREF:
        return SharedPrefUtils._APP_PREF;
      case PrefType.USER_PREF:
        return SharedPrefUtils._USER_PREF;
    }
  }
}
