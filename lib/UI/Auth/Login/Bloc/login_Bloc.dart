import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom/UI/Auth/Login/Bloc/login_Event.dart';
import 'package:flutter_ecom/data/remote/repositories/user_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_State.dart';

class Signin_Bloc extends Bloc<Signin_Event, Signin_State> {
  UserRepo userRepo;

  Signin_Bloc({required this.userRepo}) : super(LoginInitialState()) {
    on<Login_Event>((event, emit) async {
      emit(LoginLoadingState());
      try {
        var res = await userRepo.loginUser(bodyParams: event.bodyParams);
        if (res["status"]) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("tokan", res["tokan"]);
          emit(LoginSuccessState());
        } else {
          emit(LoginFailureState(errorMsg: res["message"]));
        }
      } catch (e) {
        emit(LoginFailureState(errorMsg: e.toString()));
      }
    });
  }
}
