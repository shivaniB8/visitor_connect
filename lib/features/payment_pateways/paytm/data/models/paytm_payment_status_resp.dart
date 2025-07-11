class CheckPaytmPaymentStatusResponse {
  String? message;
  int? status;
  Response? response;
  Data? data;

  CheckPaytmPaymentStatusResponse(
      {this.message, this.status, this.response, this.data});

  CheckPaytmPaymentStatusResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Response {
  String? oRDERID;
  String? bANKTXNID;
  String? pAYMENTMODE;
  String? sTATUS;

  Response({this.oRDERID, this.bANKTXNID, this.pAYMENTMODE, this.sTATUS});

  Response.fromJson(Map<String, dynamic> json) {
    oRDERID = json['ORDERID'];
    bANKTXNID = json['BANKTXNID'];
    pAYMENTMODE = json['PAYMENTMODE'];
    sTATUS = json['STATUS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ORDERID'] = this.oRDERID;
    data['BANKTXNID'] = this.bANKTXNID;
    data['PAYMENTMODE'] = this.pAYMENTMODE;
    data['STATUS'] = this.sTATUS;
    return data;
  }
}

class Data {
  int? he7;
  int? he13;
  String? z503;

  Data({this.he7, this.he13, this.z503});

  Data.fromJson(Map<String, dynamic> json) {
    he7 = json['he7'];
    he13 = json['he13'];
    z503 = json['z503'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['he7'] = this.he7;
    data['he13'] = this.he13;
    data['z503'] = this.z503;
    return data;
  }
}
