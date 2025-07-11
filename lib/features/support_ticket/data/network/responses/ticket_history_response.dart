class TicketHistoryResponse {
  bool? success;
  int? status;
  Data? data;
  String? message;

  TicketHistoryResponse({this.success, this.status, this.data, this.message});

  TicketHistoryResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? sa1;
  int? sa4;
  int? sa6;
  String? sa12;
  String? sa16;
  String? sa17;
  int? sa18;
  int? sa27;
  String? sa30;
  String? sa31;
  List<TicketMessages>? ticketMessages;

  Data(
      {this.sa1,
      this.sa4,
      this.sa6,
      this.sa12,
      this.sa16,
      this.sa17,
      this.sa18,
      this.sa27,
      this.sa30,
      this.sa31,
      this.ticketMessages});

  Data.fromJson(Map<String, dynamic> json) {
    sa1 = json['sa1'];
    sa4 = json['sa4'];
    sa6 = json['sa6'];
    sa12 = json['sa12'];
    sa16 = json['sa16'];
    sa17 = json['sa17'];
    sa18 = json['sa18'];
    sa27 = json['sa27'];
    sa30 = json['sa30'];
    sa31 = json['sa31'];
    if (json['ticket_messages'] != null) {
      ticketMessages = <TicketMessages>[];
      json['ticket_messages'].forEach((v) {
        ticketMessages!.add(new TicketMessages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sa1'] = this.sa1;
    data['sa4'] = this.sa4;
    data['sa6'] = this.sa6;
    data['sa12'] = this.sa12;
    data['sa16'] = this.sa16;
    data['sa17'] = this.sa17;
    data['sa18'] = this.sa18;
    data['sa27'] = this.sa27;
    data['sa30'] = this.sa30;
    data['sa31'] = this.sa31;
    if (this.ticketMessages != null) {
      data['ticket_messages'] =
          this.ticketMessages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TicketMessages {
  int? sb1;
  int? sb4;
  String? sb5;
  String? sb6;
  int? sb7;
  String? sb8;
  String? sb9;
  String? sb10;
  String? sb11;
  int? sb12;
  String? z501;
  String? profileimagename;

  TicketMessages(
      {this.sb1,
      this.sb4,
      this.sb5,
      this.sb6,
      this.sb7,
      this.sb8,
      this.sb9,
      this.sb10,
      this.sb11,
      this.sb12,
      this.z501,
      this.profileimagename});

  TicketMessages.fromJson(Map<String, dynamic> json) {
    sb1 = json['sb1'];
    sb4 = json['sb4'];
    sb5 = json['sb5'];
    sb6 = json['sb6'];
    sb7 = json['sb7'];
    sb8 = json['sb8'];
    sb9 = json['sb9'];
    sb10 = json['sb10'];
    sb11 = json['sb11'];
    sb12 = json['sb12'];
    z501 = json['z501'];
    profileimagename = json['profileimagename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sb1'] = this.sb1;
    data['sb4'] = this.sb4;
    data['sb5'] = this.sb5;
    data['sb6'] = this.sb6;
    data['sb7'] = this.sb7;
    data['sb8'] = this.sb8;
    data['sb9'] = this.sb9;
    data['sb10'] = this.sb10;
    data['sb11'] = this.sb11;
    data['sb12'] = this.sb12;
    data['z501'] = this.z501;
    data['profileimagename'] = this.profileimagename;
    return data;
  }
}
