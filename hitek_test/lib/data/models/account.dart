import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable()
class Account {
  String? id;
  String? username;
  String? email;
  String? gender;
  String? loginType;
  String? memberType;
  String? createdAtUnixTimeStamp;
  String? createdAt;
  String? updateAt;
  String? deleteAt;
  String? role;

  Account({
    this.id,
    this.username,
    this.email,
    this.gender,
    this.loginType,
    this.memberType,
    this.createdAtUnixTimeStamp,
    this.createdAt,
    this.updateAt,
    this.deleteAt,
    this.role,
  });

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}