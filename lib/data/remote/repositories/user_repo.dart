import 'package:flutter_ecom/data/remote/helper/api_helper.dart';
import 'package:flutter_ecom/utils/constants/app_urls.dart';

class UserRepo {
  ApiHelper apiHelper;

  UserRepo({required this.apiHelper});

  Future<dynamic> registerUser({
    required Map<String, dynamic> bodyParams,
  }) async {
    try {
      dynamic res = await apiHelper.postApi(
        url: AppUrls.registerUrl,
        isAuth: true,
        params: bodyParams,
      );
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> loginUser({required Map<String, dynamic> bodyParams}) async {
    try {
      dynamic res = await apiHelper.postApi(
        url: AppUrls.loginUrl,
        isAuth: true,
        params: bodyParams,
      );
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
