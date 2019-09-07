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

  factory Drink.fromJson(Map<String, dynamic> json) => Drink(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        price: json['price'],
        qty: json['qty'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "qty": qty,
      };
}
