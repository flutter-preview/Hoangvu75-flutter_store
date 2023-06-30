import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  String? id;
  String? title;
  int? price;
  String? description;
  String? thumbnail;
  List<String>? image;
  double? star;
  @JsonKey(name: "fake_price")
  int? fakePrice;
  @JsonKey(name: "collab_price")
  int? collabPrice;
  @JsonKey(name: "quantity_sold")
  int? quantitySold;
  @JsonKey(name: "country_of_origin")
  String? countryOfOrigin;
  @JsonKey(name: "best_sale")
  bool? bestSale;
  @JsonKey(name: "amount_search")
  int? amountSearch;
  @JsonKey(name: "amount_comment")
  int? amountComment;
  @JsonKey(name: "amount_sale")
  int? amountSale;
  String? type;
  @JsonKey(name: "is_sharing")
  bool? isSharing;
  bool? status;
  @JsonKey(name: "created_at_unix_time_stamp")
  String? createdAtUnixTimestamp;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "deleted_at")
  String? deletedAt;

  Product({
    this.id,
    this.title,
    this.price,
    this.description,
    this.thumbnail,
    this.image,
    this.fakePrice,
    this.collabPrice,
    this.quantitySold,
    this.countryOfOrigin,
    this.bestSale,
    this.amountSearch,
    this.amountComment,
    this.amountSale,
    this.type,
    this.isSharing,
    this.status,
    this.createdAtUnixTimestamp,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
