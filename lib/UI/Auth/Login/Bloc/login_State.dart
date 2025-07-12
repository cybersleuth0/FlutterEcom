abstract class Signin_State {}

class LoginInitialState extends Signin_State {}

class LoginLoadingState extends Signin_State {}

class LoginSuccessState extends Signin_State {}

class LoginFailureState extends Signin_State {
  String errorMsg;

  LoginFailureState({required this.errorMsg});
}
