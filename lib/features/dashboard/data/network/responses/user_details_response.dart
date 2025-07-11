import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_details_response.g.dart';

@JsonSerializable(explicitToJson: true)
class UserDetailsResponse extends Equatable {
  @JsonKey(name: 'ad1')
  final int? userId;

  @JsonKey(name: 'ad3')
  final String? clientName;

  @JsonKey(name: 'ad5')
  final String? title;

  @JsonKey(name: 'ad4')
  final int? fkTitle;

  @JsonKey(name: 'ad6')
  final String? firstName;

  @JsonKey(name: 'ad7')
  final String? middleName;

  @JsonKey(name: 'ad8')
  final String? lastName;

  @JsonKey(name: 'ad9')
  final String? fullName;

  @JsonKey(name: 'ad11')
  final String? designation;

  @JsonKey(name: 'ad15')
  final String? mobileNumber;

  @JsonKey(name: 'ad14')
  final int? gender;

  @JsonKey(name: 'ad18')
  final String? email;

  @JsonKey(name: 'ad22')
  final String? userPhoto;

  @JsonKey(name: 'ad25')
  final String? branch;

  @JsonKey(name: 'ad30')
  final String? address;

  @JsonKey(name: 'ad32')
  final String? branchArea;

  @JsonKey(name: 'ad34')
  final String? branchCity;

  @JsonKey(name: 'ad36')
  final String? branchState;

  @JsonKey(name: 'ad37')
  final String? branchPincode;

  @JsonKey(name: 'ad45')
  final int? resetPassword;

  @JsonKey(name: 'ad50')
  final int? userUploadDoc;

  @JsonKey(name: 'live_balance')
  final double? liveBalance;

  @JsonKey(name: 'host_logo_name')
  final String? hostLogo;

  @JsonKey(name: 'ad26')
  final int? isShowUser;

  @JsonKey(name: 'branchcategory')
  final int? branchCategory;

  @JsonKey(name: 'branch_address')
  final String? branchAddress;

  @JsonKey(name: 'lat')
  final double? latitude;

  @JsonKey(name: 'lng')
  final double? longitude;

  @JsonKey(name: 'gst_number')
  final String? gstNumber;

  @JsonKey(name: 'pan_number')
  final String? panNumber;

  const UserDetailsResponse(
      {this.gstNumber,
      this.panNumber,
      this.hostLogo,
      this.userId,
      this.clientName,
      this.fkTitle,
      this.fullName,
      this.title,
      this.firstName,
      this.middleName,
      this.lastName,
      this.mobileNumber,
      this.resetPassword,
      this.userUploadDoc,
      this.email,
      this.gender,
      this.userPhoto,
      this.branch,
      this.liveBalance,
      this.address,
      this.isShowUser,
      this.branchCategory,
      this.longitude,
      this.latitude,
      this.designation,
      this.branchArea,
      this.branchCity,
      this.branchState,
      this.branchPincode,
      this.branchAddress});

  factory UserDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsResponseToJson(this);

  @override
  List<Object?> get props => [
        userId,
        clientName,
        fullName,
        title,
        fkTitle,
        mobileNumber,
        address,
        firstName,
        middleName,
        lastName,
        email,
        hostLogo,
        gender,
        userPhoto,
        branch,
        resetPassword,
        userUploadDoc,
        liveBalance,
        isShowUser,
        branchCategory,
        latitude,
        longitude,
        designation,
        branchArea,
        branchCity,
        branchState,
        branchPincode,
        branchAddress
      ];
}
