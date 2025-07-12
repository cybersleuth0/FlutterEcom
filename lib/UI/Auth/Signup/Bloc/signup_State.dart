abstract class Signup_State {}

class SignupInitialState extends Signup_State {}

class SignupLoadingState extends Signup_State {}

class SignupSuccessState extends Signup_State {}

class SignupFailureState extends Signup_State {
  String errorMsg;

  SignupFailureState({required this.errorMsg});
}
