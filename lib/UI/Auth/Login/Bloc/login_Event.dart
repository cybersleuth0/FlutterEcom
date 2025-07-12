abstract class Signin_Event {}

class Login_Event extends Signin_Event {
  Map<String, dynamic> bodyParams;

  Login_Event({required this.bodyParams});
}
