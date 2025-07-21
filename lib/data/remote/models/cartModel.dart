class CartModel {
  int? id;
  int? product_id;
  int? quantity;
  String? price;
  String? name;
  String? image;

  CartModel({
    required this.id,
    required this.product_id,
    required this.quantity,
    required this.price,
    required this.name,
    required this.image,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json["id"],
    product_id: json["product_id"],
    quantity: json["quantity"],
    price: json["price"],
    name: json["name"],
    image: json["image"],
  );
}
