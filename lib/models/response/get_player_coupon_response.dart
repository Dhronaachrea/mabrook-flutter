import 'dart:convert';
/// errorMessage : "Success"
/// errorCode : 0
/// data : {"content":[{"logoUrl":"http://logo.com","validTillDate":null,"maxCouponValue":50.0,"wrTargetMode":"NA","wrContribution":null,"couponCode":"04de2f13-c258-47cc-8cc2-70031d37eee7","couponValue":2.0,"drawNumber":null,"wrTarget":0.0,"status":"ACTIVE","isWinningWithdrawable":"NO","description":"NEHA","drawDate":null,"couponName":"TttESTg774"},null],"pageable":null,"totalPages":1,"totalElements":29,"last":true,"first":true,"sort":{"sorted":false,"unsorted":true,"empty":true},"numberOfElements":29,"size":2000,"number":0,"empty":false}

GetPlayerCouponResponse GetPlayerCouponResponseFromJson(String str) => GetPlayerCouponResponse.fromJson(json.decode(str));
String GetPlayerCouponResponseToJson(GetPlayerCouponResponse data) => json.encode(data.toJson());
class GetPlayerCouponResponse {
  GetPlayerCouponResponse({
    String? errorMessage,
    int? errorCode,
    Data? data,}){
    _errorMessage = errorMessage;
    _errorCode = errorCode;
    _data = data;
  }

  GetPlayerCouponResponse.fromJson(dynamic json) {
    _errorMessage = json['errorMessage'];
    _errorCode = json['errorCode'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _errorMessage;
  int? _errorCode;
  Data? _data;

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

/// content : [{"logoUrl":"http://logo.com","validTillDate":null,"maxCouponValue":50.0,"wrTargetMode":"NA","wrContribution":null,"couponCode":"04de2f13-c258-47cc-8cc2-70031d37eee7","couponValue":2.0,"drawNumber":null,"wrTarget":0.0,"status":"ACTIVE","isWinningWithdrawable":"NO","description":"NEHA","drawDate":null,"couponName":"TttESTg774"},null]
/// pageable : null
/// totalPages : 1
/// totalElements : 29
/// last : true
/// first : true
/// sort : {"sorted":false,"unsorted":true,"empty":true}
/// numberOfElements : 29
/// size : 2000
/// number : 0
/// empty : false

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
    List<Content>? content,
    dynamic pageable,
    int? totalPages,
    int? totalElements,
    bool? last,
    bool? first,
    Sort? sort,
    int? numberOfElements,
    int? size,
    int? number,
    bool? empty,}){
    _content = content;
    _pageable = pageable;
    _totalPages = totalPages;
    _totalElements = totalElements;
    _last = last;
    _first = first;
    _sort = sort;
    _numberOfElements = numberOfElements;
    _size = size;
    _number = number;
    _empty = empty;
  }

  Data.fromJson(dynamic json) {
    if (json['content'] != null) {
      _content = [];
      json['content'].forEach((v) {
        _content?.add(Content.fromJson(v));
      });
    }
    _pageable = json['pageable'];
    _totalPages = json['totalPages'];
    _totalElements = json['totalElements'];
    _last = json['last'];
    _first = json['first'];
    _sort = json['sort'] != null ? Sort.fromJson(json['sort']) : null;
    _numberOfElements = json['numberOfElements'];
    _size = json['size'];
    _number = json['number'];
    _empty = json['empty'];
  }
  List<Content>? _content;
  dynamic _pageable;
  int? _totalPages;
  int? _totalElements;
  bool? _last;
  bool? _first;
  Sort? _sort;
  int? _numberOfElements;
  int? _size;
  int? _number;
  bool? _empty;

  List<Content>? get content => _content;
  dynamic get pageable => _pageable;
  int? get totalPages => _totalPages;
  int? get totalElements => _totalElements;
  bool? get last => _last;
  bool? get first => _first;
  Sort? get sort => _sort;
  int? get numberOfElements => _numberOfElements;
  int? get size => _size;
  int? get number => _number;
  bool? get empty => _empty;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_content != null) {
      map['content'] = _content?.map((v) => v.toJson()).toList();
    }
    map['pageable'] = _pageable;
    map['totalPages'] = _totalPages;
    map['totalElements'] = _totalElements;
    map['last'] = _last;
    map['first'] = _first;
    if (_sort != null) {
      map['sort'] = _sort?.toJson();
    }
    map['numberOfElements'] = _numberOfElements;
    map['size'] = _size;
    map['number'] = _number;
    map['empty'] = _empty;
    return map;
  }

}

/// sorted : false
/// unsorted : true
/// empty : true

Sort sortFromJson(String str) => Sort.fromJson(json.decode(str));
String sortToJson(Sort data) => json.encode(data.toJson());
class Sort {
  Sort({
    bool? sorted,
    bool? unsorted,
    bool? empty,}){
    _sorted = sorted;
    _unsorted = unsorted;
    _empty = empty;
  }

  Sort.fromJson(dynamic json) {
    _sorted = json['sorted'];
    _unsorted = json['unsorted'];
    _empty = json['empty'];
  }
  bool? _sorted;
  bool? _unsorted;
  bool? _empty;

  bool? get sorted => _sorted;
  bool? get unsorted => _unsorted;
  bool? get empty => _empty;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sorted'] = _sorted;
    map['unsorted'] = _unsorted;
    map['empty'] = _empty;
    return map;
  }

}

/// logoUrl : "http://logo.com"
/// validTillDate : null
/// maxCouponValue : 50.0
/// wrTargetMode : "NA"
/// wrContribution : null
/// couponCode : "04de2f13-c258-47cc-8cc2-70031d37eee7"
/// couponValue : 2.0
/// drawNumber : null
/// wrTarget : 0.0
/// status : "ACTIVE"
/// isWinningWithdrawable : "NO"
/// description : "NEHA"
/// drawDate : null
/// couponName : "TttESTg774"

Content contentFromJson(String str) => Content.fromJson(json.decode(str));
String contentToJson(Content data) => json.encode(data.toJson());
class Content {
  Content({
    String? logoUrl,
    dynamic validTillDate,
    double? maxCouponValue,
    String? wrTargetMode,
    dynamic wrContribution,
    String? couponCode,
    double? couponValue,
    dynamic drawNumber,
    double? wrTarget,
    String? status,
    String? isWinningWithdrawable,
    String? description,
    String? drawDate,
    String? couponName,
    String? ticketNumber,}){
    _logoUrl = logoUrl;
    _validTillDate = validTillDate;
    _maxCouponValue = maxCouponValue;
    _wrTargetMode = wrTargetMode;
    _wrContribution = wrContribution;
    _couponCode = couponCode;
    _couponValue = couponValue;
    _drawNumber = drawNumber;
    _wrTarget = wrTarget;
    _status = status;
    _isWinningWithdrawable = isWinningWithdrawable;
    _description = description;
    _drawDate = drawDate;
    _couponName = couponName;
    _ticketNumber = ticketNumber;
  }

  Content.fromJson(dynamic json) {
    _logoUrl = json['logoUrl'];
    _validTillDate = json['validTillDate'];
    _maxCouponValue = json['maxCouponValue'];
    _wrTargetMode = json['wrTargetMode'];
    _wrContribution = json['wrContribution'];
    _couponCode = json['couponCode'];
    _couponValue = json['couponValue'];
    _drawNumber = json['drawNumber'];
    _wrTarget = json['wrTarget'];
    _status = json['status'];
    _isWinningWithdrawable = json['isWinningWithdrawable'];
    _description = json['description'];
    _drawDate = json['drawDate'];
    _couponName = json['couponName'];
    _ticketNumber = json['ticketNumber'];
  }
  String? _logoUrl;
  dynamic _validTillDate;
  double? _maxCouponValue;
  String? _wrTargetMode;
  dynamic _wrContribution;
  String? _couponCode;
  double? _couponValue;
  dynamic _drawNumber;
  double? _wrTarget;
  String? _status;
  String? _isWinningWithdrawable;
  String? _description;
  String? _drawDate;
  String? _couponName;
  String? _ticketNumber;

  String? get logoUrl => _logoUrl;
  dynamic get validTillDate => _validTillDate;
  double? get maxCouponValue => _maxCouponValue;
  String? get wrTargetMode => _wrTargetMode;
  dynamic get wrContribution => _wrContribution;
  String? get couponCode => _couponCode;
  double? get couponValue => _couponValue;
  dynamic get drawNumber => _drawNumber;
  double? get wrTarget => _wrTarget;
  String? get status => _status;
  String? get isWinningWithdrawable => _isWinningWithdrawable;
  String? get description => _description;
  String? get drawDate => _drawDate;
  String? get couponName => _couponName;
  String? get ticketNumber => _ticketNumber;

  set status(String? val) => _status = val;
  set ticketNumber(String? val) => _ticketNumber = val;
  set drawDate(String? val) => _drawDate = val;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['logoUrl'] = _logoUrl;
    map['validTillDate'] = _validTillDate;
    map['maxCouponValue'] = _maxCouponValue;
    map['wrTargetMode'] = _wrTargetMode;
    map['wrContribution'] = _wrContribution;
    map['couponCode'] = _couponCode;
    map['couponValue'] = _couponValue;
    map['drawNumber'] = _drawNumber;
    map['wrTarget'] = _wrTarget;
    map['status'] = _status;
    map['isWinningWithdrawable'] = _isWinningWithdrawable;
    map['description'] = _description;
    map['drawDate'] = _drawDate;
    map['couponName'] = _couponName;
    map['ticketNumber'] = _ticketNumber;
    return map;
  }

}