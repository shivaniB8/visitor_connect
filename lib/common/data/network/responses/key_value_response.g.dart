// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_value_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeyValueResponse _$KeyValueResponseFromJson(Map<String, dynamic> json) =>
    KeyValueResponse(
      value: json['value'] as int?,
      label: json['label'] as String?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      pinCode: json['pincode'] as String?,
      branchAddress: json['branch_address'] as String?,
    );

Map<String, dynamic> _$KeyValueResponseToJson(KeyValueResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'label': instance.label,
      'pincode': instance.pinCode,
      'branch_address': instance.branchAddress,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };
