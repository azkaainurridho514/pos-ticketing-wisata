class QrisStatusResponseModel {
  QrisStatusResponseModel({
    required String maskedCard,
    required String approvalCode,
    required String bank,
    required String eci,
    required String channelResponseCode,
    required String channelResponseMessage,
    required DateTime transactionTime,
    required String orderId,
    required String paymentType,
    required String signatureKey,
    required String statusCode,
    required String transactionId,
    required String transactionStatus,
    required String fraudStatus,
    required DateTime settlementTime,
    required String statusMessage,
    required String merchantId,
    required String cardType,
    required String threeDsVersion,
    required bool challengeCompletion,
  }) {
    _maskedCard = maskedCard;
    _approvalCode = approvalCode;
    _bank = bank;
    _eci = eci;
    _channelResponseCode = channelResponseCode;
    _channelResponseMessage = channelResponseMessage;
    _transactionTime = transactionTime;
    _orderId = orderId;
    _paymentType = paymentType;
    _signatureKey = signatureKey;
    _statusCode = statusCode;
    _transactionId = transactionId;
    _transactionStatus = transactionStatus;
    _fraudStatus = fraudStatus;
    _settlementTime = settlementTime;
    _statusMessage = statusMessage;
    _merchantId = merchantId;
    _cardType = cardType;
    _threeDsVersion = threeDsVersion;
    _challengeCompletion = challengeCompletion;
  }

  QrisStatusResponseModel.fromJson(dynamic json) {
    _maskedCard = json['masked_card'];
    _approvalCode = json['approval_code'];
    _bank = json['bank'];
    _eci = json['eci'];
    _channelResponseCode = json['channel_response_code'];
    _channelResponseMessage = json['channel_response_message'];
    _transactionTime = DateTime.parse(json['transaction_time']);
    _orderId = json['order_id'];
    _paymentType = json['payment_type'];
    _signatureKey = json['signature_key'];
    _statusCode = json['status_code'];
    _transactionId = json['transaction_id'];
    _transactionStatus = json['transaction_status'];
    _fraudStatus = json['fraud_status'];
    _settlementTime = DateTime.parse(json['settlement_time']);
    _statusMessage = json['status_message'];
    _merchantId = json['merchant_id'];
    _cardType = json['card_type'];
    _threeDsVersion = json['three_ds_version'];
    _challengeCompletion = json['challenge_completion'];
  }
  late String _maskedCard;
  late String _approvalCode;
  late String _bank;
  late String _eci;
  late String _channelResponseCode;
  late String _channelResponseMessage;
  late DateTime _transactionTime;
  late String _orderId;
  late String _paymentType;
  late String _signatureKey;
  late String _statusCode;
  late String _transactionId;
  late String _transactionStatus;
  late String _fraudStatus;
  late DateTime _settlementTime;
  late String _statusMessage;
  late String _merchantId;
  late String _cardType;
  late String _threeDsVersion;
  late bool _challengeCompletion;
  QrisStatusResponseModel copyWith({
    required String maskedCard,
    required String approvalCode,
    required String bank,
    required String eci,
    required String channelResponseCode,
    required String channelResponseMessage,
    required DateTime transactionTime,
    required String orderId,
    required String paymentType,
    required String signatureKey,
    required String statusCode,
    required String transactionId,
    required String transactionStatus,
    required String fraudStatus,
    required DateTime settlementTime,
    required String statusMessage,
    required String merchantId,
    required String cardType,
    required String threeDsVersion,
    required bool challengeCompletion,
  }) =>
      QrisStatusResponseModel(
        maskedCard: maskedCard ?? _maskedCard,
        approvalCode: approvalCode ?? _approvalCode,
        bank: bank ?? _bank,
        eci: eci ?? _eci,
        channelResponseCode: channelResponseCode ?? _channelResponseCode,
        channelResponseMessage:
            channelResponseMessage ?? _channelResponseMessage,
        transactionTime: transactionTime ?? _transactionTime,
        orderId: orderId ?? _orderId,
        paymentType: paymentType ?? _paymentType,
        signatureKey: signatureKey ?? _signatureKey,
        statusCode: statusCode ?? _statusCode,
        transactionId: transactionId ?? _transactionId,
        transactionStatus: transactionStatus ?? _transactionStatus,
        fraudStatus: fraudStatus ?? _fraudStatus,
        settlementTime: settlementTime ?? _settlementTime,
        statusMessage: statusMessage ?? _statusMessage,
        merchantId: merchantId ?? _merchantId,
        cardType: cardType ?? _cardType,
        threeDsVersion: threeDsVersion ?? _threeDsVersion,
        challengeCompletion: challengeCompletion ?? _challengeCompletion,
      );
  String get maskedCard => _maskedCard;
  String get approvalCode => _approvalCode;
  String get bank => _bank;
  String get eci => _eci;
  String get channelResponseCode => _channelResponseCode;
  String get channelResponseMessage => _channelResponseMessage;
  DateTime get transactionTime => _transactionTime;
  String get orderId => _orderId;
  String get paymentType => _paymentType;
  String get signatureKey => _signatureKey;
  String get statusCode => _statusCode;
  String get transactionId => _transactionId;
  String get transactionStatus => _transactionStatus;
  String get fraudStatus => _fraudStatus;
  DateTime get settlementTime => _settlementTime;
  String get statusMessage => _statusMessage;
  String get merchantId => _merchantId;
  String get cardType => _cardType;
  String get threeDsVersion => _threeDsVersion;
  bool get challengeCompletion => _challengeCompletion;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['masked_card'] = _maskedCard;
    map['approval_code'] = _approvalCode;
    map['bank'] = _bank;
    map['eci'] = _eci;
    map['channel_response_code'] = _channelResponseCode;
    map['channel_response_message'] = _channelResponseMessage;
    map['transaction_time'] = _transactionTime;
    map['order_id'] = _orderId;
    map['payment_type'] = _paymentType;
    map['signature_key'] = _signatureKey;
    map['status_code'] = _statusCode;
    map['transaction_id'] = _transactionId;
    map['transaction_status'] = _transactionStatus;
    map['fraud_status'] = _fraudStatus;
    map['settlement_time'] = _settlementTime;
    map['status_message'] = _statusMessage;
    map['merchant_id'] = _merchantId;
    map['card_type'] = _cardType;
    map['three_ds_version'] = _threeDsVersion;
    map['challenge_completion'] = _challengeCompletion;
    return map;
  }
}
