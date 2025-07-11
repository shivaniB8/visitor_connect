// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailsResponse _$UserDetailsResponseFromJson(Map<String, dynamic> json) =>
    UserDetailsResponse(
      gstNumber: json['gst_number'] as String?,
      panNumber: json['pan_number'] as String?,
      hostLogo: json['host_logo_name'] as String?,
      userId: json['ad1'] as int?,
      clientName: json['ad3'] as String?,
      fkTitle: json['ad4'] as int?,
      fullName: json['ad9'] as String?,
      title: json['ad5'] as String?,
      firstName: json['ad6'] as String?,
      middleName: json['ad7'] as String?,
      lastName: json['ad8'] as String?,
      mobileNumber: json['ad15'] as String?,
      resetPassword: json['ad45'] as int?,
      userUploadDoc: json['ad50'] as int?,
      email: json['ad18'] as String?,
      gender: json['ad14'] as int?,
      userPhoto: json['ad22'] as String?,
      branch: json['ad25'] as String?,
      liveBalance: (json['live_balance'] as num?)?.toDouble(),
      address: json['ad30'] as String?,
      isShowUser: json['ad26'] as int?,
      branchCategory: json['branchcategory'] as int?,
      longitude: (json['lng'] as num?)?.toDouble(),
      latitude: (json['lat'] as num?)?.toDouble(),
      designation: json['ad11'] as String?,
      branchArea: json['ad32'] as String?,
      branchCity: json['ad34'] as String?,
      branchState: json['ad36'] as String?,
      branchPincode: json['ad37'] as String?,
      branchAddress: json['branch_address'] as String?,
    );

Map<String, dynamic> _$UserDetailsResponseToJson(
        UserDetailsResponse instance) =>
    <String, dynamic>{
      'ad1': instance.userId,
      'ad3': instance.clientName,
      'ad5': instance.title,
      'ad4': instance.fkTitle,
      'ad6': instance.firstName,
      'ad7': instance.middleName,
      'ad8': instance.lastName,
      'ad9': instance.fullName,
      'ad11': instance.designation,
      'ad15': instance.mobileNumber,
      'ad14': instance.gender,
      'ad18': instance.email,
      'ad22': instance.userPhoto,
      'ad25': instance.branch,
      'ad30': instance.address,
      'ad32': instance.branchArea,
      'ad34': instance.branchCity,
      'ad36': instance.branchState,
      'ad37': instance.branchPincode,
      'ad45': instance.resetPassword,
      'ad50': instance.userUploadDoc,
      'live_balance': instance.liveBalance,
      'host_logo_name': instance.hostLogo,
      'ad26': instance.isShowUser,
      'branchcategory': instance.branchCategory,
      'branch_address': instance.branchAddress,
      'lat': instance.latitude,
      'lng': instance.longitude,
      'gst_number': instance.gstNumber,
      'pan_number': instance.panNumber,
    };
