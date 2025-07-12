import 'package:flutter_ecom/data/remote/helper/api_helper.dart';
import 'package:flutter_ecom/utils/constants/app_urls.dart';

class ProductRepo {
  ApiHelper apiHelper;

  ProductRepo({required this.apiHelper});

  Future<dynamic> getAllProducts() async {
    try {
      dynamic res = await apiHelper.postApi(url: AppUrls.productUrl);
      print("from product repo ${res}");
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
