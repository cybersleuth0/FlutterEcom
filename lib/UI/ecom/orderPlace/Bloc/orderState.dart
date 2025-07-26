abstract class OrderState {}

class InitialOrderState extends OrderState {}

class LoadingOrderState extends OrderState {}

class SuccessOrderState extends OrderState {}

class ErrorOrderState extends OrderState {
  final errorMsg;

  ErrorOrderState({required this.errorMsg});
}
