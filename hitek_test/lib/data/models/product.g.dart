// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String?,
      title: json['title'] as String?,
      price: json['price'] as int?,
      description: json['description'] as String?,
      thumbnail: json['thumbnail'] as String?,
      image:
          (json['image'] as List<dynamic>?)?.map((e) => e as String).toList(),
      bonusPoint: json['bonus_point'] as int?,
      star: (json['star'] as num?)?.toDouble(),
      fakePrice: json['fake_price'] as int?,
      collabPrice: json['collab_price'] as int?,
      quantitySold: json['quantity_sold'] as int?,
      countryOfOrigin: json['country_of_origin'] as String?,
      bestSale: json['best_sale'] as bool?,
      amountSearch: json['amount_search'] as int?,
      amountComment: json['amount_comment'] as int?,
      amountSale: json['amount_sale'] as int?,
      type: json['type'] as String?,
      isSharing: json['is_sharing'] as bool?,
      status: json['status'] as bool?,
      createdAtUnixTimestamp: json['created_at_unix_time_stamp'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
      'image': instance.image,
      'bonus_point': instance.bonusPoint,
      'star': instance.star,
      'fake_price': instance.fakePrice,
      'collab_price': instance.collabPrice,
      'quantity_sold': instance.quantitySold,
      'country_of_origin': instance.countryOfOrigin,
      'best_sale': instance.bestSale,
      'amount_search': instance.amountSearch,
      'amount_comment': instance.amountComment,
      'amount_sale': instance.amountSale,
      'type': instance.type,
      'is_sharing': instance.isSharing,
      'status': instance.status,
      'created_at_unix_time_stamp': instance.createdAtUnixTimestamp,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };
