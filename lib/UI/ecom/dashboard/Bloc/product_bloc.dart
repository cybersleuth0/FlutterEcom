import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom/UI/ecom/dashboard/Bloc/product_event.dart';
import 'package:flutter_ecom/UI/ecom/dashboard/Bloc/product_state.dart';
import 'package:flutter_ecom/data/remote/models/productModel.dart';
import 'package:flutter_ecom/data/remote/repositories/product_repo.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepo productRepo;

  ProductBloc({required this.productRepo}) : super(ProductInitialState()) {
    on<GetAllProductsEvent>((event, emit) async {
      emit(ProductLoadingState());
      try {
        dynamic res = await productRepo.getAllProducts();
        if (res["status"]) {
          var dataModel = ProductDataModel.fromJson(res);
          emit(ProductSuccessState(products: dataModel.productsList ?? []));
        } else {
          emit(ProductFailureState(errorMsg: res["message"]));
        }
      } catch (e) {
        emit(ProductFailureState(errorMsg: e.toString()));
      }
    });
  }
}
