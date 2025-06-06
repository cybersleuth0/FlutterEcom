import 'package:flutter/cupertino.dart';
import 'package:flutter_ecom/UI_Pages/homepage.dart';
import 'package:flutter_ecom/UI_Pages/productDetails.dart';

class AppRoutes {
  static const String ROUTE_HOMEPAGE = "/homepage";
  static const String ROUTE_PRODUCT_DETAILSPAGE = "/detailsPage";
  static const String ROUTE_LOGINPAGE = "/loginpage";
  static const String ROUTE_SIGNUP = "/signup";

  static Map<String, WidgetBuilder> getRoutes() => {
    ROUTE_HOMEPAGE: (context) => Homepage(),
    ROUTE_PRODUCT_DETAILSPAGE: (context) => ProductDetails(),
    // ROUTE_LOGINPAGE: (context) => LoginPage(),
    // ROUTE_SIGNUP: (context) => SignUpPage(),
  };
}
