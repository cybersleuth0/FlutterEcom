abstract class CartEvent {}

class AddtoCartEvent extends CartEvent {
  final int productId;
  final int quantity;

  AddtoCartEvent({required this.productId, required this.quantity});
}

class FetchCartEvent extends CartEvent {}

class DecrementProductCountEvent extends CartEvent {
  final product_id;
  final quantity;

  DecrementProductCountEvent({
    required this.product_id,
    required this.quantity,
  });
}
