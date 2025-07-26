import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom/UI/ecom/orderPlace/Bloc/orderEvent.dart';
import 'package:flutter_ecom/UI/ecom/orderPlace/Bloc/orderState.dart';
import 'package:flutter_ecom/data/remote/repositories/placeOrder_repo.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  PlaceOrderRepo placeOrderRepo;

  OrderBloc({required this.placeOrderRepo}) : super(InitialOrderState()) {
    on<PlaceOrderEvent>((event, emit) async {
      emit(LoadingOrderState());
      try {
        dynamic res = await placeOrderRepo.placeOrder();
        if (res["status"]) {
          emit(SuccessOrderState());
        } else {
          emit(ErrorOrderState(errorMsg: res["message"]));
        }
      } catch (e) {
        emit(ErrorOrderState(errorMsg: e.toString()));
      }
    });
  }
}
