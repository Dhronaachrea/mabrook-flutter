import 'dart:convert';
/// responseCode : 0
/// responseMessage : "Success"
/// responseData : {"gameId":1,"gameName":"Raffle","gameCode":"Raffle","totalPurchaseAmount":2000.0,"playerPurchaseAmount":2000.0,"purchaseTime":"20-05-2022 13:17:52","ticketNumber":"31001000000115055900","panelData":[{"betType":"Direct6","pickType":"Direct6","tpticketList":null,"pickConfig":"Number","betAmountMultiple":1,"quickPick":false,"pickedValues":"788888888","qpPreGenerated":false,"numberOfLines":1,"unitCost":2000.0,"panelPrice":2000.0,"playerPanelPrice":2000.0,"betDisplayName":"Direct6","pickDisplayName":"Direct6","winningMultiplier":null}],"drawData":[{"drawName":"Raffle","drawDate":"01-07-2022","drawTime":"00:00:00","drawId":712}],"merchantCode":"Non_Trans","currencyCode":"CDF","partyType":"PLAYER","channel":"B2C","validationCode":"---r-----g--u-x-j---","ticketExpiry":"1  Days","nativeCurrencyCode":"CDF","domainCode":"mabrook","noOfDraws":1}

BuyTicketResponse buyTicketResponseFromJson(String str) => BuyTicketResponse.fromJson(json.decode(str));
String buyTicketResponseToJson(BuyTicketResponse data) => json.encode(data.toJson());
class BuyTicketResponse {
  BuyTicketResponse({
      int? responseCode, 
      String? responseMessage, 
      ResponseData? responseData,}){
    _responseCode = responseCode;
    _responseMessage = responseMessage;
    _responseData = responseData;
}

  BuyTicketResponse.fromJson(dynamic json) {
    _responseCode = json['responseCode'];
    _responseMessage = json['responseMessage'];
    _responseData = json['responseData'] != null ? ResponseData.fromJson(json['responseData']) : null;
  }
  int? _responseCode;
  String? _responseMessage;
  ResponseData? _responseData;

  int? get responseCode => _responseCode;
  String? get responseMessage => _responseMessage;
  ResponseData? get responseData => _responseData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['responseCode'] = _responseCode;
    map['responseMessage'] = _responseMessage;
    if (_responseData != null) {
      map['responseData'] = _responseData?.toJson();
    }
    return map;
  }

}

/// gameId : 1
/// gameName : "Raffle"
/// gameCode : "Raffle"
/// totalPurchaseAmount : 2000.0
/// playerPurchaseAmount : 2000.0
/// purchaseTime : "20-05-2022 13:17:52"
/// ticketNumber : "31001000000115055900"
/// panelData : [{"betType":"Direct6","pickType":"Direct6","tpticketList":null,"pickConfig":"Number","betAmountMultiple":1,"quickPick":false,"pickedValues":"788888888","qpPreGenerated":false,"numberOfLines":1,"unitCost":2000.0,"panelPrice":2000.0,"playerPanelPrice":2000.0,"betDisplayName":"Direct6","pickDisplayName":"Direct6","winningMultiplier":null}]
/// drawData : [{"drawName":"Raffle","drawDate":"01-07-2022","drawTime":"00:00:00","drawId":712}]
/// merchantCode : "Non_Trans"
/// currencyCode : "CDF"
/// partyType : "PLAYER"
/// channel : "B2C"
/// validationCode : "---r-----g--u-x-j---"
/// ticketExpiry : "1  Days"
/// nativeCurrencyCode : "CDF"
/// domainCode : "mabrook"
/// noOfDraws : 1

ResponseData responseDataFromJson(String str) => ResponseData.fromJson(json.decode(str));
String responseDataToJson(ResponseData data) => json.encode(data.toJson());
class ResponseData {
  ResponseData({
      int? gameId, 
      String? gameName, 
      String? gameCode, 
      double? totalPurchaseAmount, 
      double? playerPurchaseAmount, 
      String? purchaseTime, 
      String? ticketNumber, 
      List<PanelData>? panelData, 
      List<DrawData>? drawData, 
      String? merchantCode, 
      String? currencyCode, 
      String? partyType, 
      String? channel, 
      String? validationCode, 
      String? ticketExpiry, 
      String? nativeCurrencyCode, 
      String? domainCode, 
      int? noOfDraws,}){
    _gameId = gameId;
    _gameName = gameName;
    _gameCode = gameCode;
    _totalPurchaseAmount = totalPurchaseAmount;
    _playerPurchaseAmount = playerPurchaseAmount;
    _purchaseTime = purchaseTime;
    _ticketNumber = ticketNumber;
    _panelData = panelData;
    _drawData = drawData;
    _merchantCode = merchantCode;
    _currencyCode = currencyCode;
    _partyType = partyType;
    _channel = channel;
    _validationCode = validationCode;
    _ticketExpiry = ticketExpiry;
    _nativeCurrencyCode = nativeCurrencyCode;
    _domainCode = domainCode;
    _noOfDraws = noOfDraws;
}

  ResponseData.fromJson(dynamic json) {
    _gameId = json['gameId'];
    _gameName = json['gameName'];
    _gameCode = json['gameCode'];
    _totalPurchaseAmount = json['totalPurchaseAmount'];
    _playerPurchaseAmount = json['playerPurchaseAmount'];
    _purchaseTime = json['purchaseTime'];
    _ticketNumber = json['ticketNumber'];
    if (json['panelData'] != null) {
      _panelData = [];
      json['panelData'].forEach((v) {
        _panelData?.add(PanelData.fromJson(v));
      });
    }
    if (json['drawData'] != null) {
      _drawData = [];
      json['drawData'].forEach((v) {
        _drawData?.add(DrawData.fromJson(v));
      });
    }
    _merchantCode = json['merchantCode'];
    _currencyCode = json['currencyCode'];
    _partyType = json['partyType'];
    _channel = json['channel'];
    _validationCode = json['validationCode'];
    _ticketExpiry = json['ticketExpiry'];
    _nativeCurrencyCode = json['nativeCurrencyCode'];
    _domainCode = json['domainCode'];
    _noOfDraws = json['noOfDraws'];
  }
  int? _gameId;
  String? _gameName;
  String? _gameCode;
  double? _totalPurchaseAmount;
  double? _playerPurchaseAmount;
  String? _purchaseTime;
  String? _ticketNumber;
  List<PanelData>? _panelData;
  List<DrawData>? _drawData;
  String? _merchantCode;
  String? _currencyCode;
  String? _partyType;
  String? _channel;
  String? _validationCode;
  String? _ticketExpiry;
  String? _nativeCurrencyCode;
  String? _domainCode;
  int? _noOfDraws;

  int? get gameId => _gameId;
  String? get gameName => _gameName;
  String? get gameCode => _gameCode;
  double? get totalPurchaseAmount => _totalPurchaseAmount;
  double? get playerPurchaseAmount => _playerPurchaseAmount;
  String? get purchaseTime => _purchaseTime;
  String? get ticketNumber => _ticketNumber;
  List<PanelData>? get panelData => _panelData;
  List<DrawData>? get drawData => _drawData;
  String? get merchantCode => _merchantCode;
  String? get currencyCode => _currencyCode;
  String? get partyType => _partyType;
  String? get channel => _channel;
  String? get validationCode => _validationCode;
  String? get ticketExpiry => _ticketExpiry;
  String? get nativeCurrencyCode => _nativeCurrencyCode;
  String? get domainCode => _domainCode;
  int? get noOfDraws => _noOfDraws;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['gameId'] = _gameId;
    map['gameName'] = _gameName;
    map['gameCode'] = _gameCode;
    map['totalPurchaseAmount'] = _totalPurchaseAmount;
    map['playerPurchaseAmount'] = _playerPurchaseAmount;
    map['purchaseTime'] = _purchaseTime;
    map['ticketNumber'] = _ticketNumber;
    if (_panelData != null) {
      map['panelData'] = _panelData?.map((v) => v.toJson()).toList();
    }
    if (_drawData != null) {
      map['drawData'] = _drawData?.map((v) => v.toJson()).toList();
    }
    map['merchantCode'] = _merchantCode;
    map['currencyCode'] = _currencyCode;
    map['partyType'] = _partyType;
    map['channel'] = _channel;
    map['validationCode'] = _validationCode;
    map['ticketExpiry'] = _ticketExpiry;
    map['nativeCurrencyCode'] = _nativeCurrencyCode;
    map['domainCode'] = _domainCode;
    map['noOfDraws'] = _noOfDraws;
    return map;
  }

}

/// drawName : "Raffle"
/// drawDate : "01-07-2022"
/// drawTime : "00:00:00"
/// drawId : 712

DrawData drawDataFromJson(String str) => DrawData.fromJson(json.decode(str));
String drawDataToJson(DrawData data) => json.encode(data.toJson());
class DrawData {
  DrawData({
      String? drawName, 
      String? drawDate, 
      String? drawTime, 
      int? drawId,}){
    _drawName = drawName;
    _drawDate = drawDate;
    _drawTime = drawTime;
    _drawId = drawId;
}

  DrawData.fromJson(dynamic json) {
    _drawName = json['drawName'];
    _drawDate = json['drawDate'];
    _drawTime = json['drawTime'];
    _drawId = json['drawId'];
  }
  String? _drawName;
  String? _drawDate;
  String? _drawTime;
  int? _drawId;

  String? get drawName => _drawName;
  String? get drawDate => _drawDate;
  String? get drawTime => _drawTime;
  int? get drawId => _drawId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['drawName'] = _drawName;
    map['drawDate'] = _drawDate;
    map['drawTime'] = _drawTime;
    map['drawId'] = _drawId;
    return map;
  }

}

/// betType : "Direct6"
/// pickType : "Direct6"
/// tpticketList : null
/// pickConfig : "Number"
/// betAmountMultiple : 1
/// quickPick : false
/// pickedValues : "788888888"
/// qpPreGenerated : false
/// numberOfLines : 1
/// unitCost : 2000.0
/// panelPrice : 2000.0
/// playerPanelPrice : 2000.0
/// betDisplayName : "Direct6"
/// pickDisplayName : "Direct6"
/// winningMultiplier : null

PanelData panelDataFromJson(String str) => PanelData.fromJson(json.decode(str));
String panelDataToJson(PanelData data) => json.encode(data.toJson());
class PanelData {
  PanelData({
      String? betType, 
      String? pickType, 
      dynamic tpticketList, 
      String? pickConfig, 
      int? betAmountMultiple, 
      bool? quickPick, 
      String? pickedValues, 
      bool? qpPreGenerated, 
      int? numberOfLines, 
      double? unitCost, 
      double? panelPrice, 
      double? playerPanelPrice, 
      String? betDisplayName, 
      String? pickDisplayName, 
      dynamic winningMultiplier,}){
    _betType = betType;
    _pickType = pickType;
    _tpticketList = tpticketList;
    _pickConfig = pickConfig;
    _betAmountMultiple = betAmountMultiple;
    _quickPick = quickPick;
    _pickedValues = pickedValues;
    _qpPreGenerated = qpPreGenerated;
    _numberOfLines = numberOfLines;
    _unitCost = unitCost;
    _panelPrice = panelPrice;
    _playerPanelPrice = playerPanelPrice;
    _betDisplayName = betDisplayName;
    _pickDisplayName = pickDisplayName;
    _winningMultiplier = winningMultiplier;
}

  PanelData.fromJson(dynamic json) {
    _betType = json['betType'];
    _pickType = json['pickType'];
    _tpticketList = json['tpticketList'];
    _pickConfig = json['pickConfig'];
    _betAmountMultiple = json['betAmountMultiple'];
    _quickPick = json['quickPick'];
    _pickedValues = json['pickedValues'];
    _qpPreGenerated = json['qpPreGenerated'];
    _numberOfLines = json['numberOfLines'];
    _unitCost = json['unitCost'];
    _panelPrice = json['panelPrice'];
    _playerPanelPrice = json['playerPanelPrice'];
    _betDisplayName = json['betDisplayName'];
    _pickDisplayName = json['pickDisplayName'];
    _winningMultiplier = json['winningMultiplier'];
  }
  String? _betType;
  String? _pickType;
  dynamic _tpticketList;
  String? _pickConfig;
  int? _betAmountMultiple;
  bool? _quickPick;
  String? _pickedValues;
  bool? _qpPreGenerated;
  int? _numberOfLines;
  double? _unitCost;
  double? _panelPrice;
  double? _playerPanelPrice;
  String? _betDisplayName;
  String? _pickDisplayName;
  dynamic _winningMultiplier;

  String? get betType => _betType;
  String? get pickType => _pickType;
  dynamic get tpticketList => _tpticketList;
  String? get pickConfig => _pickConfig;
  int? get betAmountMultiple => _betAmountMultiple;
  bool? get quickPick => _quickPick;
  String? get pickedValues => _pickedValues;
  bool? get qpPreGenerated => _qpPreGenerated;
  int? get numberOfLines => _numberOfLines;
  double? get unitCost => _unitCost;
  double? get panelPrice => _panelPrice;
  double? get playerPanelPrice => _playerPanelPrice;
  String? get betDisplayName => _betDisplayName;
  String? get pickDisplayName => _pickDisplayName;
  dynamic get winningMultiplier => _winningMultiplier;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['betType'] = _betType;
    map['pickType'] = _pickType;
    map['tpticketList'] = _tpticketList;
    map['pickConfig'] = _pickConfig;
    map['betAmountMultiple'] = _betAmountMultiple;
    map['quickPick'] = _quickPick;
    map['pickedValues'] = _pickedValues;
    map['qpPreGenerated'] = _qpPreGenerated;
    map['numberOfLines'] = _numberOfLines;
    map['unitCost'] = _unitCost;
    map['panelPrice'] = _panelPrice;
    map['playerPanelPrice'] = _playerPanelPrice;
    map['betDisplayName'] = _betDisplayName;
    map['pickDisplayName'] = _pickDisplayName;
    map['winningMultiplier'] = _winningMultiplier;
    return map;
  }

}