import 'dart:convert';

/// errorMessage : "Success"
/// errorCode : 0
/// data : {"Failed_Coupon":["0188ffeb-5e41-42f8-bf95-28ccf79e4457"],"Success_Coupon":["1a2c1112-ebac-4b77-838c-59b1a63c45c4"],"Failed_Coupon_Count":1,"Successed_Coupon_Count":1}

ActivateCouponResponse activateCouponResponseFromJson(String str) =>
    ActivateCouponResponse.fromJson(json.decode(str));

String activateCouponResponseToJson(ActivateCouponResponse data) =>
    json.encode(data.toJson());

class ActivateCouponResponse {
  ActivateCouponResponse({
    String? errorMessage,
    int? errorCode,
    Data? data,
  }) {
    _errorMessage = errorMessage;
    _errorCode = errorCode;
    _data = data;
  }

  ActivateCouponResponse.fromJson(dynamic json) {
    _errorMessage = json['errorMessage'];
    _errorCode = json['errorCode'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? _errorMessage;
  int? _errorCode;
  Data? _data;

  ActivateCouponResponse copyWith({
    String? errorMessage,
    int? errorCode,
    Data? data,
  }) =>
      ActivateCouponResponse(
        errorMessage: errorMessage ?? _errorMessage,
        errorCode: errorCode ?? _errorCode,
        data: data ?? _data,
      );

  String? get errorMessage => _errorMessage;

  int? get errorCode => _errorCode;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['errorMessage'] = _errorMessage;
    map['errorCode'] = _errorCode;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// Failed_Coupon : ["0188ffeb-5e41-42f8-bf95-28ccf79e4457"]
/// Success_Coupon : ["1a2c1112-ebac-4b77-838c-59b1a63c45c4"]
/// Failed_Coupon_Count : 1
/// Successed_Coupon_Count : 1

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    List<String>? failedCoupon,
    List<String>? successCoupon,
    int? failedCouponCount,
    int? successedCouponCount,
  }) {
    _failedCoupon = failedCoupon;
    _successCoupon = successCoupon;
    _failedCouponCount = failedCouponCount;
    _successedCouponCount = successedCouponCount;
  }

  Data.fromJson(dynamic json) {
    _failedCoupon = json['Failed_Coupon'] != null
        ? json['Failed_Coupon'].cast<String>()
        : [];
    _successCoupon = json['Success_Coupon'] != null
        ? json['Success_Coupon'].cast<String>()
        : [];
    _failedCouponCount = json['Failed_Coupon_Count'];
    _successedCouponCount = json['Successed_Coupon_Count'];
  }

  List<String>? _failedCoupon;
  List<String>? _successCoupon;
  int? _failedCouponCount;
  int? _successedCouponCount;

  Data copyWith({
    List<String>? failedCoupon,
    List<String>? successCoupon,
    int? failedCouponCount,
    int? successedCouponCount,
  }) =>
      Data(
        failedCoupon: failedCoupon ?? _failedCoupon,
        successCoupon: successCoupon ?? _successCoupon,
        failedCouponCount: failedCouponCount ?? _failedCouponCount,
        successedCouponCount: successedCouponCount ?? _successedCouponCount,
      );

  List<String>? get failedCoupon => _failedCoupon;

  List<String>? get successCoupon => _successCoupon;

  int? get failedCouponCount => _failedCouponCount;

  int? get successedCouponCount => _successedCouponCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Failed_Coupon'] = _failedCoupon;
    map['Success_Coupon'] = _successCoupon;
    map['Failed_Coupon_Count'] = _failedCouponCount;
    map['Successed_Coupon_Count'] = _successedCouponCount;
    return map;
  }
}
