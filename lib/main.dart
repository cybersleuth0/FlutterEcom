import 'package:flutter/material.dart';
import 'package:flutter_ecom/utils/constants/AppConstant.dart';

void main() {
  runApp(
      MaterialApp(
          initialRoute: AppRoutes.ROUTE_SIGNUP,
          routes: AppRoutes.getRoutes(),
        debugShowCheckedModeBanner: false,
      )
  );
}
