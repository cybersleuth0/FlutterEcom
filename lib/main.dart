import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom/UI/Auth/Login/Bloc/login_Bloc.dart';
import 'package:flutter_ecom/UI/ecom/Profile/Bloc/profile_Bloc.dart';
import 'package:flutter_ecom/UI/ecom/dashboard/Bloc/product_bloc.dart';
import 'package:flutter_ecom/UI/ecom/orderPlace/Bloc/orderBloc.dart';
import 'package:flutter_ecom/data/remote/helper/api_helper.dart';
import 'package:flutter_ecom/data/remote/repositories/placeOrder_repo.dart';
import 'package:flutter_ecom/data/remote/repositories/user_repo.dart';
import 'package:flutter_ecom/utils/constants/AppConstant.dart';

import 'UI/Auth/Signup/Bloc/signup_Bloc.dart';
import 'UI/ecom/product_detail/Bloc/cart_Bloc.dart';
import 'data/remote/repositories/cart_repo.dart';
import 'data/remote/repositories/product_repo.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              Signup_Bloc(userRepo: UserRepo(apiHelper: ApiHelper())),
        ),
        BlocProvider(
          create: (context) =>
              Signin_Bloc(userRepo: UserRepo(apiHelper: ApiHelper())),
        ),
        BlocProvider(
          create: (context) =>
              ProductBloc(productRepo: ProductRepo(apiHelper: ApiHelper())),
        ),
        BlocProvider(
          create: (context) =>
              CartBloc(cartRepo: CartRepo(apiHelper: ApiHelper())),
        ),
        BlocProvider(create: (context) => ProfileBloc(apiHelper: ApiHelper())),
        BlocProvider(
          create: (context) =>
              OrderBloc(placeOrderRepo: PlaceOrderRepo(apiHelper: ApiHelper())),
        ),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.system,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        initialRoute: AppRoutes.ROUTE_SPLASHSCREEN,
        routes: AppRoutes.getRoutes(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: Color(0xffff650e),
      // Primary orange color
      secondary: Color(0xff4CAF50),
      // Green accent
      surface: Colors.white,
      background: Color(0xffF5F5F5),
      // Light gray background
      onBackground: Colors.black87,
      onSurface: Colors.black87,
    ),
    scaffoldBackgroundColor: Color(0xffF5F5F5),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black87),
      titleTextStyle: TextStyle(
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 14),
      bodySmall: TextStyle(fontSize: 12),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xffff650e),
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xffff650e),
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xffff650e),
      unselectedItemColor: Colors.grey,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Color(0xffff650e),
      // Keep the same primary color
      secondary: Color(0xff4CAF50),
      // Green accent
      surface: Color(0xff121212),
      background: Color(0xff121212),
      onBackground: Colors.white,
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: Color(0xff121212),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 14),
      bodySmall: TextStyle(fontSize: 12),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Color(0xff1E1E1E),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xff1E1E1E),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xffff650e),
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xffff650e),
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xff1E1E1E),
      selectedItemColor: Color(0xffff650e),
      unselectedItemColor: Colors.grey,
    ),
  );
}
