import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'app_exception.dart';

class ApiHelper {
  Future<dynamic> getApi({
    required String url,
    Map<String, String>? mHeaders,
    bool isAuth = false,
  }) async {
    if (!isAuth) {
      //we will get the token from the shared preference
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokan") ?? "";
      mHeaders ??= {};
      mHeaders["Authorization"] = "Bearer $token";
    }

    try {
      var res = await http.get(Uri.parse(url), headers: mHeaders);
      return returnResponse(response: res);
    } on SocketException catch (e) {
      //SocketException == Network Issue
      throw NoInternetException(errorMessage: "");
    }
  }

  Future<dynamic> postApi({
    required String url,
    Map<String, dynamic>? params,
    Map<String, String>? mHeaders,
    bool isAuth = false,
  }) async {
    if (!isAuth) {
      //we will get the token from the shared preference
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokan") ?? "";
      mHeaders ??= {};
      mHeaders["Authorization"] = "Bearer $token";
    }
    try {
      var res = await http.post(
        Uri.parse(url),
        body: params != null ? jsonEncode(params) : null,
        headers: mHeaders,
      );
      return returnResponse(response: res);
    } on SocketException catch (e) {
      //SocketException == Network Issue
      throw NoInternetException(errorMessage: "");
    }
  }

  dynamic returnResponse({required http.Response response}) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(errorMessage: response.body);
      case 401:
      case 403:
        throw UnauthorisedException(errorMessage: response.body);
      case 500:
      default:
        throw FetchDataException(errorMessage: response.body);
    }
  }
}
