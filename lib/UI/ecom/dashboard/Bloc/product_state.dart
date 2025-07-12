import 'package:flutter_ecom/data/remote/models/productModel.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductSuccessState extends ProductState {
  List<ProductModel> products;

  ProductSuccessState({required this.products});
}

class ProductFailureState extends ProductState {
  String errorMsg;

  ProductFailureState({required this.errorMsg});
}
