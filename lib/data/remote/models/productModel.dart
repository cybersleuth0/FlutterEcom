class ProductModel {
  String? id;
  String? name;
  String? price;
  String? image;
  String? category_id;
  String? status;
  String? created_at;
  String? updated_at;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.category_id,
    required this.status,
    required this.created_at,
    required this.updated_at,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    name: json["name"].toString(),
    price: json["price"],
    image: json["image"],
    category_id: json["category_id"],
    status: json["status"],
    created_at: json["created_at"],
    updated_at: json["updated_at"],
  );
}

class ProductDataModel {
  List<ProductModel>? productsList;
  String? message;
  bool? status;

  ProductDataModel(
      {required this.productsList, required this.message, required this.status});

  // factory ProductDataModel.fromJson(Map<String, dynamic> json) =>
  //     ProductDataModel(
  //       message: json["message"],
  //       status: json["status"],
  //       productsList: List<ProductModel>.from(
  //         json["data"].map((item) => ProductModel.fromJson(json)),
  //       ),
  //     );

  factory ProductDataModel.fromJson(Map<String, dynamic> json) =>
      ProductDataModel(
        message: json["message"],
        status: json["status"],
        productsList: List<ProductModel>.from(json["data"]
            .map((item) => ProductModel.fromJson(item))),
      );

}
