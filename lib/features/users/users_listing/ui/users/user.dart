import 'package:equatable/equatable.dart';
import 'package:host_visitor_connect/features/users/users_listing/data/network/response/users_data_response.dart';

class User extends Equatable {
  final int? id;
  final int? fkTitle;
  final String? titile;
  final int? hostFk;
  final String? fullName;
  final String? designation;
  final int? age;
  final int? gender;
  final int? branchValue;
  final String? role;
  final String? dateOfBirth;
  final String? mobileNo;
  final String? email;
  final String? image;
  final String? address;
  final String? lastUpdatedBy;
  final String? updatedAt;
  final String? businessType;

  const User({
    this.id,
    this.fkTitle,
    this.dateOfBirth,
    this.designation,
    this.titile,
    this.role,
    this.branchValue,
    this.fullName,
    this.age,
    this.hostFk,
    this.gender,
    this.mobileNo,
    this.email,
    this.image,
    this.address,
    this.lastUpdatedBy,
    this.updatedAt,
    this.businessType,
  });

  factory User.fromApiResponse(
    UsersDataResponse usersResponse,
  ) {
    return User(
      id: usersResponse.id,
      fullName: usersResponse.fullName,
      fkTitle: usersResponse.titleFk,
      titile: usersResponse.title,
      hostFk: usersResponse.hostFk,
      role: usersResponse.role,
      age: usersResponse.age,
      designation: usersResponse.designation,
      dateOfBirth: usersResponse.birthDate,
      gender: usersResponse.gender,
      mobileNo: usersResponse.mobileNumber,
      email: usersResponse.emailId,
      image: usersResponse.photo,
      address: usersResponse.address,
      branchValue: usersResponse.branchValue,
      lastUpdatedBy: usersResponse.updatedBy,
      updatedAt: usersResponse.updatedAt,
      businessType: usersResponse.businessType,
    );
  }

  @override
  List<Object?> get props => [
        id,
        hostFk,
        designation,
        fullName,
        dateOfBirth,
        titile,
        age,
        gender,
        role,
        mobileNo,
        email,
        image,
        branchValue,
        address,
        lastUpdatedBy,
        updatedAt,
        fkTitle,
        businessType,
      ];
}
