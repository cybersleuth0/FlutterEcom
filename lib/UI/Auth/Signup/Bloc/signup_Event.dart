abstract class Signup_Event {}

class Register_Event extends Signup_Event {
  Map<String, dynamic> bodyParams;
  Register_Event({required this.bodyParams});
}
