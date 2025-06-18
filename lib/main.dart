import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom/UI/Signup/Bloc/signup_Bloc.dart';
import 'package:flutter_ecom/data/remote/helper/api_helper.dart';
import 'package:flutter_ecom/data/remote/repositories/user_repo.dart';
import 'package:flutter_ecom/utils/constants/AppConstant.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) =>
            Signup_Bloc(userRepo: UserRepo(apiHelper: ApiHelper())))
      ],
      child: MaterialApp(
        initialRoute: AppRoutes.ROUTE_SIGNUP,
        routes: AppRoutes.getRoutes(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
