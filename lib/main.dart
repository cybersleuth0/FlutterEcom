import 'package:flutter/material.dart';
import 'package:flutter_ecom/UI_Pages/AppConstant.dart';

void main() {
  runApp(
      MaterialApp(
          initialRoute: AppRoutes.ROUTE_HOMEPAGE,
          routes: AppRoutes.getRoutes(),
          debugShowCheckedModeBanner: false));
}
