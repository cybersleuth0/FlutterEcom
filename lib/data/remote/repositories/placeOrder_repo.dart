import 'package:flutter_ecom/data/remote/helper/api_helper.dart';
import 'package:flutter_ecom/utils/constants/app_urls.dart';

class PlaceOrderRepo {
  ApiHelper apiHelper;

  PlaceOrderRepo({required this.apiHelper});

  Future<dynamic> placeOrder() async {
    try {
      var res = await apiHelper.postApi(url: AppUrls.placeOrderUrl);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
