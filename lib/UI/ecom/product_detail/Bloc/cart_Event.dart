abstract class CartEvent {}

class AddtoCartEvent extends CartEvent {
  final int productId;
  final int quantity;

  AddtoCartEvent({required this.productId, required this.quantity});
}

class FetchCartEvent extends CartEvent {}
