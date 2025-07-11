class BarGraphResp {
  int? status;
  bool? success;
  Data? data;
  String? message;

  BarGraphResp({this.status, this.success, this.data, this.message});

  BarGraphResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? currentMonthDebit;
  int? percentage;
  Day? monday;
  Day? tuesday;
  Day? wednesday;
  Day? thursday;
  Day? friday;
  Day? saturday;
  Day? sunday;

  Data(
      {this.currentMonthDebit,
      this.percentage,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.sunday});

  Data.fromJson(Map<String, dynamic> json) {
    currentMonthDebit = json['currentMonthDebit'];
    percentage = json['percentage'];
    monday = json['Monday'] != null ? new Day.fromJson(json['Monday']) : null;
    tuesday =
        json['Tuesday'] != null ? new Day.fromJson(json['Tuesday']) : null;
    wednesday =
        json['Wednesday'] != null ? new Day.fromJson(json['Wednesday']) : null;
    thursday =
        json['Thursday'] != null ? new Day.fromJson(json['Thursday']) : null;
    friday = json['Friday'] != null ? new Day.fromJson(json['Friday']) : null;
    saturday =
        json['Saturday'] != null ? new Day.fromJson(json['Saturday']) : null;
    sunday = json['Sunday'] != null ? new Day.fromJson(json['Sunday']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentMonthDebit'] = currentMonthDebit;
    data['percentage'] = this.percentage;
    if (this.monday != null) {
      data['Monday'] = this.monday!.toJson();
    }
    if (this.tuesday != null) {
      data['Tuesday'] = this.tuesday!.toJson();
    }
    if (this.wednesday != null) {
      data['Wednesday'] = this.wednesday!.toJson();
    }
    if (this.thursday != null) {
      data['Thursday'] = this.thursday!.toJson();
    }
    if (this.friday != null) {
      data['Friday'] = this.friday!.toJson();
    }
    if (this.saturday != null) {
      data['Saturday'] = this.saturday!.toJson();
    }
    if (this.sunday != null) {
      data['Sunday'] = this.sunday!.toJson();
    }
    return data;
  }
}

class Day {
  int? f0;

  Day({this.f0});

  Day.fromJson(Map<String, dynamic> json) {
    if (json['f0_'] != null) {
      f0 = json['f0_'].toInt();
    } else {
      f0 = json['f0_'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['f0_'] = this.f0;
    return data;
  }
}
