import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom/UI/ecom/product_detail/Bloc/cart_Event.dart';
import 'package:flutter_ecom/UI/ecom/product_detail/Bloc/cart_State.dart';
import 'package:flutter_ecom/data/remote/models/cartModel.dart';
import 'package:flutter_ecom/data/remote/repositories/cart_repo.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepo cartRepo;

  CartBloc({required this.cartRepo}) : super(CartInitial_State()) {
    on<AddtoCartEvent>((event, emit) async {
      emit(CartLoading_State());
      try {
        var res = await cartRepo.addTocart(
          productId: event.productId,
          quantity: event.quantity,
        );
        if (res["status"] == "true" || res["status"]) {
          emit(CartSuccess_State(cartList: []));
        } else {
          emit(CartError_State(errorMsg: '${res["message"]}'));
        }
      } catch (e) {
        emit(CartError_State(errorMsg: e.toString()));
      }
    });

    on<FetchCartEvent>((event, emit) async {
      emit(CartLoading_State());
      try {
        var res = await cartRepo.fetchCart();
        if (res["status"]) {
          List<CartModel> mCart = [];
          for (var item in res["data"]) {
            mCart.add(CartModel.fromJson(item));
          }
          emit(CartSuccess_State(cartList: mCart));
        } else {
          emit(CartError_State(errorMsg: '${res["message"]}'));
        }
      } catch (e) {
        emit(CartError_State(errorMsg: e.toString()));
      }
    });
    on<DecrementProductCountEvent>((event, emit) async {
      emit(CartLoading_State());
      try {
        var res = await cartRepo.decrementProductCount(
          event.product_id,
          event.quantity,
        );
        print(res);
        var cart = await cartRepo.fetchCart();
        if (cart["status"]) {
          List<CartModel> mCart = [];
          for (var item in res["data"]) {
            mCart.add(CartModel.fromJson(item));
          }
          emit(CartSuccess_State(cartList: mCart));
        } else {
          emit(CartError_State(errorMsg: '${res["message"]}'));
        }
      } catch (e) {
        emit(CartError_State(errorMsg: e.toString()));
      }
    });
  }
}
