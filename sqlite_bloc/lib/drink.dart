import 'package:json_annotation/json_annotation.dart';

part 'drink.g.dart';

@JsonSerializable()
class Drink {
  int id;
  String name;
  String image;
  double price;
  int qty;

  Drink({
    this.id,
    this.name,
    this.image,
    this.price,
    this.qty,
  });

  factory Drink.fromJson(Map<String, dynamic> json) => _$DrinkFromJson(json);

  Map<String, dynamic> toJson() => _$DrinkToJson(this);
}
