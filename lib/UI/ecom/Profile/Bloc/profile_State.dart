abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class ProfileLoadingState extends ProfileStates {}

class ProfileSuccessState extends ProfileStates {
  Map<String, dynamic> userData;

  ProfileSuccessState({required this.userData});
}

class ProfileFailureState extends ProfileStates {
  final String errorMsg;

  ProfileFailureState({required this.errorMsg});
}
