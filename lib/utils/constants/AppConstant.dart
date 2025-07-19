import 'package:flutter/cupertino.dart';
import 'package:flutter_ecom/UI/ecom/Profile/profile.dart';

import '../../UI/Auth/Login/login_page.dart';
import '../../UI/Auth/Signup/Signup_page.dart';
import '../../UI/SplashScreen.dart';
import '../../UI/ecom/dashboard/homepage.dart';
import '../../UI/ecom/product_detail/cartPage.dart';
import '../../UI/ecom/product_detail/productDetails.dart';

class AppRoutes {
  static const String ROUTE_HOMEPAGE = "/homepage";
  static const String ROUTE_PRODUCT_DETAILSPAGE = "/detailsPage";
  static const String ROUTE_CART_PAGE = "/cartPage";
  static const String ROUTE_LOGINPAGE = "/loginpage";
  static const String ROUTE_SIGNUP = "/signup";
  static const String ROUTE_SPLASHSCREEN = "/splashscreen";
  static const String ROUTE_PROFILE = "/profile";

  static Map<String, WidgetBuilder> getRoutes() => {
    ROUTE_HOMEPAGE: (context) => Homepage(),
    ROUTE_PRODUCT_DETAILSPAGE: (context) => ProductDetails(),
    ROUTE_CART_PAGE: (context) => Cartpage(),
    ROUTE_LOGINPAGE: (context) => LoginPage(),
    ROUTE_SIGNUP: (context) => SignupPage(),
    ROUTE_SPLASHSCREEN: (context) => SplashScreenPage(),
    ROUTE_PROFILE: (context) => ProfilePage(),
  };
}
