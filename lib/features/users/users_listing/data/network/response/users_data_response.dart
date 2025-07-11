import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'users_data_response.g.dart';

@JsonSerializable(explicitToJson: true)
class UsersDataResponse extends Equatable {
  @JsonKey(name: 'ad1')
  final int? id;

  @JsonKey(name: 'ad2')
  final int? hostFk;

  @JsonKey(name: 'ad4')
  final int? titleFk;

  @JsonKey(name: 'ad5')
  final String? title;

  @JsonKey(name: 'ad9')
  final String? fullName;

  @JsonKey(name: 'ad11')
  final String? designation;

  @JsonKey(name: 'ad13')
  final int? age;

  @JsonKey(name: 'ad14')
  final int? gender;

  @JsonKey(name: 'ad18')
  final String? emailId;

  @JsonKey(name: 'ad12')
  final String? birthDate;

  @JsonKey(name: 'ad22')
  final String? photo;

  @JsonKey(name: 'ad27')
  final String? role;

  @JsonKey(name: 'ad15')
  final String? mobileNumber;

  @JsonKey(name: 'ad30')
  final String? address;

  @JsonKey(name: 'branchcategory')
  final int? branchValue;

  @JsonKey(name: 'z506')
  final String? updatedAt;

  @JsonKey(name: 'z508')
  final String? updatedBy;

  @JsonKey(name: 'business_type')
  final String? businessType;

  const UsersDataResponse({
    this.id,
    this.hostFk,
    this.titleFk,
    this.title,
    this.emailId,
    this.fullName,
    this.designation,
    this.age,
    this.gender,
    this.birthDate,
    this.photo,
    this.role,
    this.mobileNumber,
    this.address,
    this.branchValue,
    this.updatedAt,
    this.updatedBy,
    this.businessType,
  });

  factory UsersDataResponse.fromJson(Map<String, dynamic> json) =>
      _$UsersDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UsersDataResponseToJson(this);

  @override
  List<Object?> get props => <Object?>[
        id,
        hostFk,
        titleFk,
        title,
        fullName,
        designation,
        age,
        gender,
        birthDate,
        photo,
        role,
        emailId,
        mobileNumber,
        address,
        branchValue,
        updatedAt,
        updatedBy,
        businessType,
      ];
}
