import 'package:flutter/cupertino.dart';
import 'package:flutter_ecom/UI_Pages/ecom/cartPage.dart';
import 'package:flutter_ecom/UI_Pages/ecom/homepage.dart';
import 'package:flutter_ecom/UI_Pages/ecom/productDetails.dart';

class AppRoutes {
  static const String ROUTE_HOMEPAGE = "/homepage";
  static const String ROUTE_PRODUCT_DETAILSPAGE = "/detailsPage";
  static const String ROUTE_CART_PAGE = "/cartPage";
  static const String ROUTE_LOGINPAGE = "/loginpage";
  static const String ROUTE_SIGNUP = "/signup";

  static Map<String, WidgetBuilder> getRoutes() => {
    ROUTE_HOMEPAGE: (context) => Homepage(),
    ROUTE_PRODUCT_DETAILSPAGE: (context) => ProductDetails(),
    ROUTE_CART_PAGE: (context) => Cartpage(),
    // ROUTE_LOGINPAGE: (context) => LoginPage(),
    // ROUTE_SIGNUP: (context) => SignUpPage(),
  };
}
