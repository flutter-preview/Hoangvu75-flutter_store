// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      id: json['id'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      loginType: json['json_type'] as String?,
      memberType: json['member_type'] as String?,
      createdAtUnixTimeStamp: json['created_at_unix_time_stamp'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'gender': instance.gender,
      'json_type': instance.loginType,
      'member_type': instance.memberType,
      'created_at_unix_time_stamp': instance.createdAtUnixTimeStamp,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
      'role': instance.role,
    };
