import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom/UI/Signup/Bloc/signup_Event.dart';
import 'package:flutter_ecom/UI/Signup/Bloc/signup_State.dart';
import 'package:flutter_ecom/data/remote/repositories/user_repo.dart';

class Signup_Bloc extends Bloc<Signup_Event, Signup_State> {
  UserRepo userRepo;

  Signup_Bloc({required this.userRepo}) : super(SignupInitialState()) {
    on<Register_Event>((event, emit) async {
      emit(SignupLoadingState());
      try {
        var res = await userRepo.registerUser(bodyParams: event.bodyParams);

        if (res["status"]) {
          emit(SignupSuccessState());
        } else {
          emit(SignupFailureState(errorMsg: res["message"]));
        }
      } catch (e) {
        emit(SignupFailureState(errorMsg: e.toString()));
      }
    });
  }
}
