class TicketResponse {
  int? sa1;
  int? sa4;
  int? sa5;
  int? sa7;
  String? sa8;
  String? sa9;
  Null? sa10;
  Null? sa11;
  String? sa12;
  String? sa13;
  int? sa14;
  String? sa15;
  String? sa16;
  String? sa17;
  int? sa18;
  String? sa28;
  String? sa41;
  int? sa27;
  int? sa26;
  String? sa30;
  String? sa31;
  String? sa32;
  String? sa35;
  int? sa37;
  String? z501;
  int? z502;
  String? z503;
  String? z504;
  String? z505;
  String? z506;
  int? z507;
  String? z508;
  String? z509;

  TicketResponse(
      {this.sa1,
      this.sa4,
      this.sa5,
      this.sa7,
      this.sa41,
      this.sa8,
      this.sa28,
      this.sa17,
      this.sa9,
      this.sa10,
      this.sa11,
      this.sa12,
      this.sa13,
      this.sa14,
      this.sa15,
      this.sa16,
      this.sa18,
      this.sa26,
      this.sa27,
      this.sa30,
      this.sa31,
      this.sa32,
      this.sa35,
      this.sa37,
      this.z501,
      this.z502,
      this.z503,
      this.z504,
      this.z505,
      this.z506,
      this.z507,
      this.z508,
      this.z509});

  TicketResponse.fromJson(Map<String, dynamic> json) {
    sa1 = json['sa1'];
    sa4 = json['sa4'];
    sa5 = json['sa5'];
    sa7 = json['sa7'];
    sa8 = json['sa8'];
    sa28 = json['sa28'];
    sa41 = json['sa41'];

    sa9 = json['sa9'];
    sa10 = json['sa10'];
    sa11 = json['sa11'];
    sa12 = json['sa12'];
    sa13 = json['sa13'];
    sa14 = json['sa14'];
    sa15 = json['sa15'];
    sa16 = json['sa16'];
    sa17 = json['sa17'];

    sa18 = json['sa18'];
    sa26 = json['sa26'];
    sa27 = json['sa27'];
    sa30 = json['sa30'];
    sa31 = json['sa31'];
    sa32 = json['sa32'];
    sa35 = json['sa35'];
    sa37 = json['sa37'];
    z501 = json['z501'];
    z502 = json['z502'];
    z503 = json['z503'];
    z504 = json['z504'];
    z505 = json['z505'];
    z506 = json['z506'];
    z507 = json['z507'];
    z508 = json['z508'];
    z509 = json['z509'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sa1'] = this.sa1;
    data['sa4'] = this.sa4;
    data['sa5'] = this.sa5;
    data['sa7'] = this.sa7;
    data['sa41'] = this.sa41;
    data['sa8'] = this.sa8;
    data['sa9'] = this.sa9;
    data['sa10'] = this.sa10;
    data['sa17'] = this.sa17;
    data['sa11'] = this.sa11;
    data['sa12'] = this.sa12;
    data['sa28'] = this.sa28;
    data['sa13'] = this.sa13;
    data['sa14'] = this.sa14;
    data['sa15'] = this.sa15;
    data['sa16'] = this.sa16;
    data['sa18'] = this.sa18;
    data['sa26'] = this.sa26;
    data['sa27'] = this.sa27;
    data['sa30'] = this.sa30;
    data['sa31'] = this.sa31;
    data['sa32'] = this.sa32;
    data['sa35'] = this.sa35;
    data['sa37'] = this.sa37;
    data['z501'] = this.z501;
    data['z502'] = this.z502;
    data['z503'] = this.z503;
    data['z504'] = this.z504;
    data['z505'] = this.z505;
    data['z506'] = this.z506;
    data['z507'] = this.z507;
    data['z508'] = this.z508;
    data['z509'] = this.z509;
    return data;
  }
}
