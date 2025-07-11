class PaytmTokenResponse {
  String? message;
  int? status;
  Response? response;
  String? orderId;
  String? paytoken;

  PaytmTokenResponse(
      {this.message, this.status, this.response, this.orderId, this.paytoken});

  PaytmTokenResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
    orderId = json['order_id'];
    paytoken = json['paytoken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    data['order_id'] = this.orderId;
    data['paytoken'] = this.paytoken;
    return data;
  }
}

class Response {
  Body? body;
  Head? head;

  Response({this.body, this.head});

  Response.fromJson(Map<String, dynamic> json) {
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
    head = json['head'] != null ? new Head.fromJson(json['head']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.body != null) {
      data['body'] = this.body!.toJson();
    }
    if (this.head != null) {
      data['head'] = this.head!.toJson();
    }
    return data;
  }
}

class Body {
  String? requestType;
  String? mid;
  String? websiteName;
  String? orderId;
  String? callbackUrl;
  TxnAmount? txnAmount;
  UserInfo? userInfo;

  Body(
      {this.requestType,
        this.mid,
        this.websiteName,
        this.orderId,
        this.callbackUrl,
        this.txnAmount,
        this.userInfo});

  Body.fromJson(Map<String, dynamic> json) {
    requestType = json['requestType'];
    mid = json['mid'];
    websiteName = json['websiteName'];
    orderId = json['orderId'];
    callbackUrl = json['callbackUrl'];
    txnAmount = json['txnAmount'] != null
        ? new TxnAmount.fromJson(json['txnAmount'])
        : null;
    userInfo = json['userInfo'] != null
        ? new UserInfo.fromJson(json['userInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestType'] = this.requestType;
    data['mid'] = this.mid;
    data['websiteName'] = this.websiteName;
    data['orderId'] = this.orderId;
    data['callbackUrl'] = this.callbackUrl;
    if (this.txnAmount != null) {
      data['txnAmount'] = this.txnAmount!.toJson();
    }
    if (this.userInfo != null) {
      data['userInfo'] = this.userInfo!.toJson();
    }
    return data;
  }
}

class TxnAmount {
  int? value;
  String? currency;

  TxnAmount({this.value, this.currency});

  TxnAmount.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['currency'] = this.currency;
    return data;
  }
}

class UserInfo {
  String? custId;
  String? mobile;

  UserInfo({this.custId, this.mobile});

  UserInfo.fromJson(Map<String, dynamic> json) {
    custId = json['custId'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['custId'] = this.custId;
    data['mobile'] = this.mobile;
    return data;
  }
}

class Head {
  String? signature;

  Head({this.signature});

  Head.fromJson(Map<String, dynamic> json) {
    signature = json['signature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['signature'] = this.signature;
    return data;
  }
}
