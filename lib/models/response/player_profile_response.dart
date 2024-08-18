class PlayerProfileResponse {
  Mapping? mapping;
  PlayerInfoBean? playerInfoBean;
  String? profileStatus;
  int? errorCode;
  RamPlayerInfo? ramPlayerInfo;
  List<Null>? latestDocuments;
  bool? profileUpdate;
  RamPlayerData? ramPlayerData;
  String? domainName;
  BasicPlayerInfo? basicPlayerInfo;
  String? docUploadStatus;
  bool? fistDeposited;
  RamAddressInfo? ramAddressInfo;

  PlayerProfileResponse({this.mapping, this.playerInfoBean, this.profileStatus, this.errorCode, this.ramPlayerInfo, this.latestDocuments, this.profileUpdate, this.ramPlayerData, this.domainName, this.basicPlayerInfo, this.docUploadStatus, this.fistDeposited, this.ramAddressInfo});

  PlayerProfileResponse.fromJson(Map<String, dynamic> json) {
    mapping = json['mapping'] != null ?  Mapping.fromJson(json['mapping']) : null;
    playerInfoBean = json['playerInfoBean'] != null ?  PlayerInfoBean.fromJson(json['playerInfoBean']) : null;
    profileStatus = json['profileStatus'];
    errorCode = json['errorCode'];
    ramPlayerInfo = json['ramPlayerInfo'] != null ?  RamPlayerInfo.fromJson(json['ramPlayerInfo']) : null;
    if (json['latestDocuments'] != null) {
      latestDocuments = <Null>[];
      /*json['latestDocuments'].forEach((v) { latestDocuments!.add( Null.fromJson(v)); });*/
    }
    profileUpdate = json['profileUpdate'];
    ramPlayerData = json['ramPlayerData'] != null ?  RamPlayerData.fromJson(json['ramPlayerData']) : null;
    domainName = json['domainName'];
    basicPlayerInfo = json['basicPlayerInfo'] != null ?  BasicPlayerInfo.fromJson(json['basicPlayerInfo']) : null;
    docUploadStatus = json['docUploadStatus'];
    fistDeposited = json['fistDeposited'];
    ramAddressInfo = json['ramAddressInfo'] != null ?  RamAddressInfo.fromJson(json['ramAddressInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.mapping != null) {
      data['mapping'] = this.mapping!.toJson();
    }
    if (this.playerInfoBean != null) {
      data['playerInfoBean'] = this.playerInfoBean!.toJson();
    }
    data['profileStatus'] = this.profileStatus;
    data['errorCode'] = this.errorCode;
    if (this.ramPlayerInfo != null) {
      data['ramPlayerInfo'] = this.ramPlayerInfo!.toJson();
    }
    if (this.latestDocuments != null) {
      /*data['latestDocuments'] = this.latestDocuments!.map((v) => v.toJson()).toList();*/
    }
    data['profileUpdate'] = this.profileUpdate;
    if (this.ramPlayerData != null) {
      data['ramPlayerData'] = this.ramPlayerData!.toJson();
    }
    data['domainName'] = this.domainName;
    if (this.basicPlayerInfo != null) {
      data['basicPlayerInfo'] = this.basicPlayerInfo!.toJson();
    }
    data['docUploadStatus'] = this.docUploadStatus;
    data['fistDeposited'] = this.fistDeposited;
    if (this.ramAddressInfo != null) {
      data['ramAddressInfo'] = this.ramAddressInfo!.toJson();
    }
    return data;
  }
}

class Mapping {


  Mapping();

Mapping.fromJson(Map<String, dynamic> json) {
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data =  Map<String, dynamic>();
  return data;
}
}

class PlayerInfoBean {
  String? lastName;
  String? country;
  String? gender;
  WalletBean? walletBean;
  String? phoneVerified;
  String? mobileNumber;
  String? avatarPath;
  bool? otpVerified;
  String? emailId;
  int? mobileNo;
  String? userName;
  String? firstName;
  String? emailVerified;
  String? dob;
  String? countryCode;
  String? commonContentPath;
  bool? sms;
  String? addressLine;
  bool? ussd;
  bool? isOtpVerified;
  String? requestedEmailId;
  String? playerStatus;
  int? currencyId;
  int? playerId;

  PlayerInfoBean({this.lastName, this.country, this.gender, this.walletBean, this.phoneVerified, this.mobileNumber, this.avatarPath, this.otpVerified, this.emailId, this.mobileNo, this.userName, this.firstName, this.emailVerified, this.dob, this.countryCode, this.commonContentPath, this.sms, this.addressLine, this.ussd, this.isOtpVerified, this.requestedEmailId, this.playerStatus, this.currencyId, this.playerId});

  PlayerInfoBean.fromJson(Map<String, dynamic> json) {
    lastName = json['lastName'];
    country = json['country'];
    gender = json['gender'];
    walletBean = json['walletBean'] != null ?  WalletBean.fromJson(json['walletBean']) : null;
    phoneVerified = json['phoneVerified'];
    mobileNumber = json['mobileNumber'];
    avatarPath = json['avatarPath'];
    otpVerified = json['otpVerified'];
    emailId = json['emailId'];
    mobileNo = json['mobileNo'];
    userName = json['userName'];
    firstName = json['firstName'];
    emailVerified = json['emailVerified'];
    dob = json['dob'];
    countryCode = json['countryCode'];
    commonContentPath = json['commonContentPath'];
    sms = json['sms'];
    addressLine = json['addressLine'];
    ussd = json['ussd'];
    isOtpVerified = json['isOtpVerified'];
    requestedEmailId = json['requestedEmailId'];
    playerStatus = json['playerStatus'];
    currencyId = json['currencyId'];
    playerId = json['playerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['lastName'] = this.lastName;
    data['country'] = this.country;
    data['gender'] = this.gender;
    if (this.walletBean != null) {
      data['walletBean'] = this.walletBean!.toJson();
    }
    data['phoneVerified'] = this.phoneVerified;
    data['mobileNumber'] = this.mobileNumber;
    data['avatarPath'] = this.avatarPath;
    data['otpVerified'] = this.otpVerified;
    data['emailId'] = this.emailId;
    data['mobileNo'] = this.mobileNo;
    data['userName'] = this.userName;
    data['firstName'] = this.firstName;
    data['emailVerified'] = this.emailVerified;
    data['dob'] = this.dob;
    data['countryCode'] = this.countryCode;
    data['commonContentPath'] = this.commonContentPath;
    data['sms'] = this.sms;
    data['addressLine'] = this.addressLine;
    data['ussd'] = this.ussd;
    data['isOtpVerified'] = this.isOtpVerified;
    data['requestedEmailId'] = this.requestedEmailId;
    data['playerStatus'] = this.playerStatus;
    data['currencyId'] = this.currencyId;
    data['playerId'] = this.playerId;
    return data;
  }
}

class WalletBean {
  double? totalBalance;
  double? cashBalance;
  double? depositBalance;
  double? winningBalance;
  double? bonusBalance;
  double? withdrawableBal;
  double? practiceBalance;
  double? totalDepositBalance;
  double? totalWithdrawableBalance;
  double? totalWinningBalance;

  WalletBean({this.totalBalance, this.cashBalance, this.depositBalance, this.winningBalance, this.bonusBalance, this.withdrawableBal, this.practiceBalance, this.totalDepositBalance, this.totalWithdrawableBalance, this.totalWinningBalance});

  WalletBean.fromJson(Map<String, dynamic> json) {
    totalBalance = json['totalBalance'];
    cashBalance = json['cashBalance'];
    depositBalance = json['depositBalance'];
    winningBalance = json['winningBalance'];
    bonusBalance = json['bonusBalance'];
    withdrawableBal = json['withdrawableBal'];
    practiceBalance = json['practiceBalance'];
    totalDepositBalance = json['totalDepositBalance'];
    totalWithdrawableBalance = json['totalWithdrawableBalance'];
    totalWinningBalance = json['totalWinningBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['totalBalance'] = this.totalBalance;
    data['cashBalance'] = this.cashBalance;
    data['depositBalance'] = this.depositBalance;
    data['winningBalance'] = this.winningBalance;
    data['bonusBalance'] = this.bonusBalance;
    data['withdrawableBal'] = this.withdrawableBal;
    data['practiceBalance'] = this.practiceBalance;
    data['totalDepositBalance'] = this.totalDepositBalance;
    data['totalWithdrawableBalance'] = this.totalWithdrawableBalance;
    data['totalWinningBalance'] = this.totalWinningBalance;
    return data;
  }
}

class RamPlayerInfo {
  int? id;
  int? merchantId;
  int? domainId;
  int? playerId;
  String? addressVerified;
  String? nameVerified;
  String? emailVerified;
  String? mobileVerified;
  String? ageVerified;
  String? taxationIdVerified;
  String? securityQuestionVerified;
  String? idVerified;
  String? bankVerified;
  String? addressVerifiedAt;
  String? profileStatus;
  String? kycStatus;
  String? emailVerifiedAt;
  String? mobileVerifiedAt;
  String? ageVerifiedAt;
  String? taxationIdVerifiedAt;
  String? securityQuestionVerifiedAt;
  String? idVerifiedAt;
  String? bankVerifiedAt;
  String? createdAt;
  String? updatedAt;
  dynamic profileExpiredAt;
  String? docUploaded;
  dynamic uploadPendingDate;
  dynamic verifiedBy;
  dynamic verificationAssignAt;
  dynamic verificationModeAt;
  dynamic addressVerifiedBy;
  dynamic idVerifiedBy;
  dynamic bankVerifiedBy;

  RamPlayerInfo({this.id, this.merchantId, this.domainId, this.playerId, this.addressVerified, this.nameVerified, this.emailVerified, this.mobileVerified, this.ageVerified, this.taxationIdVerified, this.securityQuestionVerified, this.idVerified, this.bankVerified, this.addressVerifiedAt, this.profileStatus, this.kycStatus, this.emailVerifiedAt, this.mobileVerifiedAt, this.ageVerifiedAt, this.taxationIdVerifiedAt, this.securityQuestionVerifiedAt, this.idVerifiedAt, this.bankVerifiedAt, this.createdAt, this.updatedAt, this.profileExpiredAt, this.docUploaded, this.uploadPendingDate, this.verifiedBy, this.verificationAssignAt, this.verificationModeAt, this.addressVerifiedBy, this.idVerifiedBy, this.bankVerifiedBy});

  RamPlayerInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    merchantId = json['merchantId'];
    domainId = json['domainId'];
    playerId = json['playerId'];
    addressVerified = json['addressVerified'];
    nameVerified = json['nameVerified'];
    emailVerified = json['emailVerified'];
    mobileVerified = json['mobileVerified'];
    ageVerified = json['ageVerified'];
    taxationIdVerified = json['taxationIdVerified'];
    securityQuestionVerified = json['securityQuestionVerified'];
    idVerified = json['idVerified'];
    bankVerified = json['bankVerified'];
    addressVerifiedAt = json['addressVerifiedAt'];
    profileStatus = json['profileStatus'];
    kycStatus = json['kycStatus'];
    emailVerifiedAt = json['emailVerifiedAt'];
    mobileVerifiedAt = json['mobileVerifiedAt'];
    ageVerifiedAt = json['ageVerifiedAt'];
    taxationIdVerifiedAt = json['taxationIdVerifiedAt'];
    securityQuestionVerifiedAt = json['securityQuestionVerifiedAt'];
    idVerifiedAt = json['idVerifiedAt'];
    bankVerifiedAt = json['bankVerifiedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    profileExpiredAt = json['profileExpiredAt'];
    docUploaded = json['docUploaded'];
    uploadPendingDate = json['uploadPendingDate'];
    verifiedBy = json['verifiedBy'];
    verificationAssignAt = json['verificationAssignAt'];
    verificationModeAt = json['verificationModeAt'];
    addressVerifiedBy = json['addressVerifiedBy'];
    idVerifiedBy = json['idVerifiedBy'];
    bankVerifiedBy = json['bankVerifiedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['merchantId'] = this.merchantId;
    data['domainId'] = this.domainId;
    data['playerId'] = this.playerId;
    data['addressVerified'] = this.addressVerified;
    data['nameVerified'] = this.nameVerified;
    data['emailVerified'] = this.emailVerified;
    data['mobileVerified'] = this.mobileVerified;
    data['ageVerified'] = this.ageVerified;
    data['taxationIdVerified'] = this.taxationIdVerified;
    data['securityQuestionVerified'] = this.securityQuestionVerified;
    data['idVerified'] = this.idVerified;
    data['bankVerified'] = this.bankVerified;
    data['addressVerifiedAt'] = this.addressVerifiedAt;
    data['profileStatus'] = this.profileStatus;
    data['kycStatus'] = this.kycStatus;
    data['emailVerifiedAt'] = this.emailVerifiedAt;
    data['mobileVerifiedAt'] = this.mobileVerifiedAt;
    data['ageVerifiedAt'] = this.ageVerifiedAt;
    data['taxationIdVerifiedAt'] = this.taxationIdVerifiedAt;
    data['securityQuestionVerifiedAt'] = this.securityQuestionVerifiedAt;
    data['idVerifiedAt'] = this.idVerifiedAt;
    data['bankVerifiedAt'] = this.bankVerifiedAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['profileExpiredAt'] = this.profileExpiredAt;
    data['docUploaded'] = this.docUploaded;
    data['uploadPendingDate'] = this.uploadPendingDate;
    data['verifiedBy'] = this.verifiedBy;
    data['verificationAssignAt'] = this.verificationAssignAt;
    data['verificationModeAt'] = this.verificationModeAt;
    data['addressVerifiedBy'] = this.addressVerifiedBy;
    data['idVerifiedBy'] = this.idVerifiedBy;
    data['bankVerifiedBy'] = this.bankVerifiedBy;
    return data;
  }
}

class RamPlayerData {
  int? playerId;
  int? merchantId;
  int? domainId;
  int? aliasId;
  int? vipLevelId;
  String? merchantPlayerId;
  String? autoPassword;
  String? mobileNo;
  String? username;
  String? password;
  String? emailId;
  String? userImagePath;
  String? registrationDate;
  String? lastLoginCity;
  String? lastLoginCountryCode;
  String? lastLoginIp;
  String? lastLoginThrough;
  String? profileStatus;
  String? plrStatus;
  dynamic profileExpiredAt;
  String? affiliateBind;
  dynamic affiliateId;
  dynamic affiliateReference;
  String? referFriendCode;
  String? regDevice;
  String? profileType;
  String? userAgent;
  int? invalidLoginTry;
  String? lastLoginDate;
  dynamic uploadPendingDate;
  String? createdAt;
  String? updatedAt;
  int? securityQuestionCount;
  String? inactiveDate;
  String? accountStatus;
  String? failedLoginBlockDate;

  RamPlayerData({this.playerId, this.merchantId, this.domainId, this.aliasId, this.vipLevelId, this.merchantPlayerId, this.autoPassword, this.mobileNo, this.username, this.password, this.emailId, this.userImagePath, this.registrationDate, this.lastLoginCity, this.lastLoginCountryCode, this.lastLoginIp, this.lastLoginThrough, this.profileStatus, this.plrStatus, this.profileExpiredAt, this.affiliateBind, this.affiliateId, this.affiliateReference, this.referFriendCode, this.regDevice, this.profileType, this.userAgent, this.invalidLoginTry, this.lastLoginDate, this.uploadPendingDate, this.createdAt, this.updatedAt, this.securityQuestionCount, this.inactiveDate, this.accountStatus, this.failedLoginBlockDate});

  RamPlayerData.fromJson(Map<String, dynamic> json) {
    playerId = json['playerId'];
    merchantId = json['merchantId'];
    domainId = json['domainId'];
    aliasId = json['aliasId'];
    vipLevelId = json['vipLevelId'];
    merchantPlayerId = json['merchantPlayerId'];
    autoPassword = json['autoPassword'];
    mobileNo = json['mobileNo'];
    username = json['username'];
    password = json['password'];
    emailId = json['emailId'];
    userImagePath = json['userImagePath'];
    registrationDate = json['registrationDate'];
    lastLoginCity = json['lastLoginCity'];
    lastLoginCountryCode = json['lastLoginCountryCode'];
    lastLoginIp = json['lastLoginIp'];
    lastLoginThrough = json['lastLoginThrough'];
    profileStatus = json['profileStatus'];
    plrStatus = json['plrStatus'];
    profileExpiredAt = json['profileExpiredAt'];
    affiliateBind = json['affiliateBind'];
    affiliateId = json['affiliateId'];
    affiliateReference = json['affiliateReference'];
    referFriendCode = json['referFriendCode'];
    regDevice = json['regDevice'];
    profileType = json['profileType'];
    userAgent = json['userAgent'];
    invalidLoginTry = json['invalidLoginTry'];
    lastLoginDate = json['lastLoginDate'];
    uploadPendingDate = json['uploadPendingDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    securityQuestionCount = json['securityQuestionCount'];
    inactiveDate = json['inactiveDate'];
    accountStatus = json['accountStatus'];
    failedLoginBlockDate = json['failedLoginBlockDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['playerId'] = this.playerId;
    data['merchantId'] = this.merchantId;
    data['domainId'] = this.domainId;
    data['aliasId'] = this.aliasId;
    data['vipLevelId'] = this.vipLevelId;
    data['merchantPlayerId'] = this.merchantPlayerId;
    data['autoPassword'] = this.autoPassword;
    data['mobileNo'] = this.mobileNo;
    data['username'] = this.username;
    data['password'] = this.password;
    data['emailId'] = this.emailId;
    data['userImagePath'] = this.userImagePath;
    data['registrationDate'] = this.registrationDate;
    data['lastLoginCity'] = this.lastLoginCity;
    data['lastLoginCountryCode'] = this.lastLoginCountryCode;
    data['lastLoginIp'] = this.lastLoginIp;
    data['lastLoginThrough'] = this.lastLoginThrough;
    data['profileStatus'] = this.profileStatus;
    data['plrStatus'] = this.plrStatus;
    data['profileExpiredAt'] = this.profileExpiredAt;
    data['affiliateBind'] = this.affiliateBind;
    data['affiliateId'] = this.affiliateId;
    data['affiliateReference'] = this.affiliateReference;
    data['referFriendCode'] = this.referFriendCode;
    data['regDevice'] = this.regDevice;
    data['profileType'] = this.profileType;
    data['userAgent'] = this.userAgent;
    data['invalidLoginTry'] = this.invalidLoginTry;
    data['lastLoginDate'] = this.lastLoginDate;
    data['uploadPendingDate'] = this.uploadPendingDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['securityQuestionCount'] = this.securityQuestionCount;
    data['inactiveDate'] = this.inactiveDate;
    data['accountStatus'] = this.accountStatus;
    data['failedLoginBlockDate'] = this.failedLoginBlockDate;
    return data;
  }
}

class BasicPlayerInfo {
  int? id;
  int? playerId;
  int? domainId;
  int? aliasId;
  String? gender;
  String? dateOfBirth;
  String? firstName;
  String? middleName;
  String? lastName;
  String? addressOne;
  String? addressTwo;
  String? city;
  String? town;
  String? state;
  String? country;
  String? zip;
  String? currencyCode;
  String? regCity;
  String? regCountryCode;
  String? regIp;
  String? reason;
  int? invalidChangepwdTry;
  String? invalidChangepwdDate;
  int? playerAge;
  dynamic smsOpted;
  dynamic emailOpted;
  dynamic fcmIdAndroid;
  dynamic fcmIdIos;
  dynamic currAppVer;
  dynamic primaryIdValue;
  dynamic isPep;
  String? nationality;

  BasicPlayerInfo({this.id, this.playerId, this.domainId, this.aliasId, this.gender, this.dateOfBirth, this.firstName, this.middleName, this.lastName, this.addressOne, this.addressTwo, this.city, this.town, this.state, this.country, this.zip, this.currencyCode, this.regCity, this.regCountryCode, this.regIp, this.reason, this.invalidChangepwdTry, this.invalidChangepwdDate, this.playerAge, this.smsOpted, this.emailOpted, this.fcmIdAndroid, this.fcmIdIos, this.currAppVer, this.primaryIdValue, this.isPep, this.nationality});

  BasicPlayerInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    playerId = json['playerId'];
    domainId = json['domainId'];
    aliasId = json['aliasId'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    addressOne = json['addressOne'];
    addressTwo = json['addressTwo'];
    city = json['city'];
    town = json['town'];
    state = json['state'];
    country = json['country'];
    zip = json['zip'];
    currencyCode = json['currencyCode'];
    regCity = json['regCity'];
    regCountryCode = json['regCountryCode'];
    regIp = json['regIp'];
    reason = json['reason'];
    invalidChangepwdTry = json['invalidChangepwdTry'];
    invalidChangepwdDate = json['invalidChangepwdDate'];
    playerAge = json['playerAge'];
    smsOpted = json['smsOpted'];
    emailOpted = json['emailOpted'];
    fcmIdAndroid = json['fcmIdAndroid'];
    fcmIdIos = json['fcmIdIos'];
    currAppVer = json['currAppVer'];
    primaryIdValue = json['primaryIdValue'];
    isPep = json['isPep'];
    nationality = json['nationality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['playerId'] = this.playerId;
    data['domainId'] = this.domainId;
    data['aliasId'] = this.aliasId;
    data['gender'] = this.gender;
    data['dateOfBirth'] = this.dateOfBirth;
    data['firstName'] = this.firstName;
    data['middleName'] = this.middleName;
    data['lastName'] = this.lastName;
    data['addressOne'] = this.addressOne;
    data['addressTwo'] = this.addressTwo;
    data['city'] = this.city;
    data['town'] = this.town;
    data['state'] = this.state;
    data['country'] = this.country;
    data['zip'] = this.zip;
    data['currencyCode'] = this.currencyCode;
    data['regCity'] = this.regCity;
    data['regCountryCode'] = this.regCountryCode;
    data['regIp'] = this.regIp;
    data['reason'] = this.reason;
    data['invalidChangepwdTry'] = this.invalidChangepwdTry;
    data['invalidChangepwdDate'] = this.invalidChangepwdDate;
    data['playerAge'] = this.playerAge;
    data['smsOpted'] = this.smsOpted;
    data['emailOpted'] = this.emailOpted;
    data['fcmIdAndroid'] = this.fcmIdAndroid;
    data['fcmIdIos'] = this.fcmIdIos;
    data['currAppVer'] = this.currAppVer;
    data['primaryIdValue'] = this.primaryIdValue;
    data['isPep'] = this.isPep;
    data['nationality'] = this.nationality;
    return data;
  }
}

class RamAddressInfo {
  dynamic zip;
  String? country;
  dynamic town;
  dynamic city;
  String? addressTwo;
  String? countryCode;
  String? stateCode;
  String? state;
  String? addressOne;

  RamAddressInfo({this.zip, this.country, this.town, this.city, this.addressTwo, this.countryCode, this.stateCode, this.state, this.addressOne});

  RamAddressInfo.fromJson(Map<String, dynamic> json) {
    zip = json['zip'];
    country = json['country'];
    town = json['town'];
    city = json['city'];
    addressTwo = json['addressTwo'];
    countryCode = json['countryCode'];
    stateCode = json['stateCode'];
    state = json['state'];
    addressOne = json['addressOne'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['zip'] = this.zip;
    data['country'] = this.country;
    data['town'] = this.town;
    data['city'] = this.city;
    data['addressTwo'] = this.addressTwo;
    data['countryCode'] = this.countryCode;
    data['stateCode'] = this.stateCode;
    data['state'] = this.state;
    data['addressOne'] = this.addressOne;
    return data;
  }
}
