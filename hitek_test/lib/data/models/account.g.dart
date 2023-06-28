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
      loginType: json['loginType'] as String?,
      memberType: json['memberType'] as String?,
      createdAtUnixTimeStamp: json['createdAtUnixTimeStamp'] as String?,
      createdAt: json['createdAt'] as String?,
      updateAt: json['updateAt'] as String?,
      deleteAt: json['deleteAt'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'gender': instance.gender,
      'loginType': instance.loginType,
      'memberType': instance.memberType,
      'createdAtUnixTimeStamp': instance.createdAtUnixTimeStamp,
      'createdAt': instance.createdAt,
      'updateAt': instance.updateAt,
      'deleteAt': instance.deleteAt,
      'role': instance.role,
    };
