// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drink.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Drink _$DrinkFromJson(Map<String, dynamic> json) {
  return Drink(
    id: json['id'] as int,
    name: json['name'] as String,
    image: json['image'] as String,
    price: (json['price'] as num)?.toDouble(),
    qty: json['qty'] as int,
  );
}

Map<String, dynamic> _$DrinkToJson(Drink instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
      'qty': instance.qty,
    };
