
import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable()
class Account {
  String? id;
  String? username;
  String? email;
  String? gender;
  @JsonKey(name: "json_type")
  String? loginType;
  @JsonKey(name: "member_type")
  String? memberType;
  @JsonKey(name: "created_at_unix_time_stamp")
  String? createdAtUnixTimeStamp;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "deleted_at")
  String? deletedAt;
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
    this.updatedAt,
    this.deletedAt,
    this.role,
  });

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}