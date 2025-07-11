class ReceiptResponse {
  int? status;
  bool? success;
  List<ReceiptResponseData>? data;
  int? count;
  String? message;

  ReceiptResponse(
      {this.status, this.success, this.data, this.count, this.message});

  ReceiptResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = <ReceiptResponseData>[];
      json['data'].forEach((v) {
        data!.add(new ReceiptResponseData.fromJson(v));
      });
    }
    count = json['count'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    data['message'] = this.message;
    return data;
  }
}

class ReceiptResponseData {
  String? hc1;
  int? hc2;
  String? hc3;
  int? hc4;
  String? hc5;
  String? hc6;
  int? hc7;
  String? hc8;
  String? hc9;
  String? hc10;
  int? hc11;
  String? hc12;
  int? hc13;
  String? hc14;
  String? hc15;
  String? hc16;
  int? hc17;
  String? hc18;
  int? hc19;
  int? hc20;
  String? hc21;
  String? hc22;
  int? hc23;
  String? hc24;
  int? hc25;
  int? hc26;

  ReceiptResponseData(
      {this.hc1,
      this.hc2,
      this.hc3,
      this.hc4,
      this.hc5,
      this.hc6,
      this.hc7,
      this.hc8,
      this.hc9,
      this.hc10,
      this.hc11,
      this.hc12,
      this.hc13,
      this.hc14,
      this.hc15,
      this.hc16,
      this.hc17,
      this.hc18,
      this.hc19,
      this.hc20,
      this.hc21,
      this.hc22,
      this.hc23,
      this.hc24,
      this.hc25,
      this.hc26});

  ReceiptResponseData.fromJson(Map<String, dynamic> json) {
    hc1 = json['hc1'];
    hc2 = json['hc2'];
    hc3 = json['hc3'];
    hc4 = json['hc4'];
    hc5 = json['hc5'];
    hc6 = json['hc6'];
    hc7 = json['hc7'];
    hc8 = json['hc8'];
    hc9 = json['hc9'];
    hc10 = json['hc10'];
    hc11 = json['hc11'];
    hc12 = json['hc12'];
    hc13 = json['hc13'];
    hc14 = json['hc14'];
    hc15 = json['hc15'];
    hc16 = json['hc16'];
    hc17 = json['hc17'];
    hc18 = json['hc18'];
    hc19 = json['hc19'];
    hc20 = json['hc20'];
    hc21 = json['hc21'];
    hc22 = json['hc22'];
    hc23 = json['hc23'];
    hc24 = json['hc24'];
    hc25 = json['hc25'];
    hc26 = json['hc26'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hc1'] = this.hc1;
    data['hc2'] = this.hc2;
    data['hc3'] = this.hc3;
    data['hc4'] = this.hc4;
    data['hc5'] = this.hc5;
    data['hc6'] = this.hc6;
    data['hc7'] = this.hc7;
    data['hc8'] = this.hc8;
    data['hc9'] = this.hc9;
    data['hc10'] = this.hc10;
    data['hc11'] = this.hc11;
    data['hc12'] = this.hc12;
    data['hc13'] = this.hc13;
    data['hc14'] = this.hc14;
    data['hc15'] = this.hc15;
    data['hc16'] = this.hc16;
    data['hc17'] = this.hc17;
    data['hc18'] = this.hc18;
    data['hc19'] = this.hc19;
    data['hc20'] = this.hc20;
    data['hc21'] = this.hc21;
    data['hc22'] = this.hc22;
    data['hc23'] = this.hc23;
    data['hc24'] = this.hc24;
    data['hc25'] = this.hc25;
    data['hc26'] = this.hc26;
    return data;
  }
}
