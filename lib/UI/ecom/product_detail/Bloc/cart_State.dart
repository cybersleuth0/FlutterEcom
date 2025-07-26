import '../../../../data/remote/models/cartModel.dart';

abstract class CartState {}

class CartInitial_State extends CartState {}

class CartLoading_State extends CartState {}

class CartSuccess_State extends CartState {
  final List<CartModel> cartList;

  CartSuccess_State({required this.cartList});
}

class CartError_State extends CartState {
  final String errorMsg;

  CartError_State({required this.errorMsg});
}
