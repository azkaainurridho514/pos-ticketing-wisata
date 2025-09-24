class QrisResponseModel {
  QrisResponseModel({
    required String statusCode,
    required String statusMessage,
    required String transactionId,
    required String orderId,
    required String merchantId,
    required String grossAmount,
    required String currency,
    required String paymentType,
    required String transactionTime,
    required String transactionStatus,
    required String fraudStatus,
    required List<Actions> actions,
    required String expiryTime,
  }) {
    _statusCode = statusCode;
    _statusMessage = statusMessage;
    _transactionId = transactionId;
    _orderId = orderId;
    _merchantId = merchantId;
    _grossAmount = grossAmount;
    _currency = currency;
    _paymentType = paymentType;
    _transactionTime = transactionTime;
    _transactionStatus = transactionStatus;
    _fraudStatus = fraudStatus;
    _actions = actions;
    _expiryTime = expiryTime;
  }

  QrisResponseModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _statusMessage = json['status_message'];
    _transactionId = json['transaction_id'];
    _orderId = json['order_id'];
    _merchantId = json['merchant_id'];
    _grossAmount = json['gross_amount'];
    _currency = json['currency'];
    _paymentType = json['payment_type'];
    _transactionTime = json['transaction_time'];
    _transactionStatus = json['transaction_status'];
    _fraudStatus = json['fraud_status'];
    if (json['actions'] != null) {
      _actions = [];
      json['actions'].forEach((v) {
        _actions.add(Actions.fromJson(v));
      });
    }
    _expiryTime = json['expiry_time'];
  }
  late String _statusCode;
  late String _statusMessage;
  late String _transactionId;
  late String _orderId;
  late String _merchantId;
  late String _grossAmount;
  late String _currency;
  late String _paymentType;
  late String _transactionTime;
  late String _transactionStatus;
  late String _fraudStatus;
  late List<Actions> _actions;
  late String _expiryTime;
  QrisResponseModel copyWith({
    required String statusCode,
    required String statusMessage,
    required String transactionId,
    required String orderId,
    required String merchantId,
    required String grossAmount,
    required String currency,
    required String paymentType,
    required String transactionTime,
    required String transactionStatus,
    required String fraudStatus,
    required List<Actions>? actions,
    required String expiryTime,
  }) =>
      QrisResponseModel(
        statusCode: statusCode ?? _statusCode,
        statusMessage: statusMessage ?? _statusMessage,
        transactionId: transactionId ?? _transactionId,
        orderId: orderId ?? _orderId,
        merchantId: merchantId ?? _merchantId,
        grossAmount: grossAmount ?? _grossAmount,
        currency: currency ?? _currency,
        paymentType: paymentType ?? _paymentType,
        transactionTime: transactionTime ?? _transactionTime,
        transactionStatus: transactionStatus ?? _transactionStatus,
        fraudStatus: fraudStatus ?? _fraudStatus,
        actions: actions ?? _actions,
        expiryTime: expiryTime ?? _expiryTime,
      );
  String get statusCode => _statusCode;
  String get statusMessage => _statusMessage;
  String get transactionId => _transactionId;
  String get orderId => _orderId;
  String get merchantId => _merchantId;
  String get grossAmount => _grossAmount;
  String get currency => _currency;
  String get paymentType => _paymentType;
  String get transactionTime => _transactionTime;
  String get transactionStatus => _transactionStatus;
  String get fraudStatus => _fraudStatus;
  List<Actions> get actions => _actions;
  String get expiryTime => _expiryTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = _statusCode;
    map['status_message'] = _statusMessage;
    map['transaction_id'] = _transactionId;
    map['order_id'] = _orderId;
    map['merchant_id'] = _merchantId;
    map['gross_amount'] = _grossAmount;
    map['currency'] = _currency;
    map['payment_type'] = _paymentType;
    map['transaction_time'] = _transactionTime;
    map['transaction_status'] = _transactionStatus;
    map['fraud_status'] = _fraudStatus;
    if (_actions != null) {
      map['actions'] = _actions.map((v) => v.toJson()).toList();
    }
    map['expiry_time'] = _expiryTime;
    return map;
  }
}

class Actions {
  Actions({
    required String name,
    required String method,
    required String url,
  }) {
    _name = name;
    _method = method;
    _url = url;
  }

  Actions.fromJson(dynamic json) {
    _name = json['name'];
    _method = json['method'];
    _url = json['url'];
  }
  late String _name;
  late String _method;
  late String _url;
  Actions copyWith({
    String? name,
    String? method,
    String? url,
  }) =>
      Actions(
        name: name ?? _name,
        method: method ?? _method,
        url: url ?? _url,
      );
  String get name => _name;
  String get method => _method;
  String get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['method'] = _method;
    map['url'] = _url;
    return map;
  }
}
