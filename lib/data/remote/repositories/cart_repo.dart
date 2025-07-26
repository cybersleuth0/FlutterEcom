import 'package:flutter_ecom/data/remote/helper/api_helper.dart';
import 'package:flutter_ecom/utils/constants/app_urls.dart';

class CartRepo {
  ApiHelper apiHelper;

  CartRepo({required this.apiHelper});

  Future<dynamic> addTocart({
    required int productId,
    required int quantity,
  }) async {
    var bodyparms = {"product_id": productId, "quantity": quantity};
    try {
      var res = await apiHelper.postApi(
        url: AppUrls.addToCartUrl,
        params: bodyparms,
      );
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> fetchCart() async {
    try {
      var res = await apiHelper.getApi(url: AppUrls.fetchCartUrl);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> decrementProductCount(int productId, int quantity) async {
    final bodyparms = {"product_id": productId, "quantity": quantity};
    try {
      var res = await apiHelper.postApi(
        url: AppUrls.decrementProductCount,
        params: bodyparms,
      );
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
