class BranchModel {
  bool? success;
  int? status;
  Data? data;
  String? masterBucketName;
  String? message;

  BranchModel(
      {this.success,
      this.status,
      this.data,
      this.masterBucketName,
      this.message});

  BranchModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    masterBucketName = json['master_bucket_name'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['master_bucket_name'] = masterBucketName;
    data['message'] = message;
    return data;
  }
}

class Data {
  int? ad1;
  int? ad2;
  String? ad9;
  String? ad22;
  int? branchcategory;
  List<HostBranchesList>? hostBranchesList;

  Data(
      {this.ad1,
      this.ad2,
      this.ad9,
      this.ad22,
      this.branchcategory,
      this.hostBranchesList});

  Data.fromJson(Map<String, dynamic> json) {
    ad1 = json['ad1'];
    ad2 = json['ad2'];
    ad9 = json['ad9'];
    ad22 = json['ad22'];
    branchcategory = json['branchcategory'];
    if (json['host_branches_list'] != null) {
      hostBranchesList = <HostBranchesList>[];
      json['host_branches_list'].forEach((v) {
        hostBranchesList!.add(HostBranchesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ad1'] = ad1;
    data['ad2'] = ad2;
    data['ad9'] = ad9;
    data['ad22'] = ad22;
    data['branchcategory'] = branchcategory;
    if (hostBranchesList != null) {
      data['host_branches_list'] =
          hostBranchesList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HostBranchesList {
  int? value;
  String? label;
  int? ae2;
  double? latitude;
  double? longitude;

  HostBranchesList(
      {this.value, this.label, this.ae2, this.latitude, this.longitude});

  HostBranchesList.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    label = json['label'];
    ae2 = json['ae2'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['label'] = label;
    data['ae2'] = ae2;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
