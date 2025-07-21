import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom/UI/Auth/Login/Bloc/login_Bloc.dart';
import 'package:flutter_ecom/UI/ecom/Profile/Bloc/profile_Bloc.dart';
import 'package:flutter_ecom/UI/ecom/dashboard/Bloc/product_bloc.dart';
import 'package:flutter_ecom/data/remote/helper/api_helper.dart';
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
              CartBloc(cartRepo: CartRepo(apiHelper: ApiHelper())),
        ),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.system,
        //Dark theme
        darkTheme: ThemeData.dark(useMaterial3: true),
        theme: ThemeData(
          useMaterial3: true,
          //light Theme
          textTheme: TextTheme(
            bodyMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            bodySmall: TextStyle(fontSize: 16),
          ),
        ),
        initialRoute: AppRoutes.ROUTE_SPLASHSCREEN,
        routes: AppRoutes.getRoutes(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
