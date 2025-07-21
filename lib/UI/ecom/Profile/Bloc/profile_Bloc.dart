import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom/UI/ecom/Profile/Bloc/profile_Event.dart';
import 'package:flutter_ecom/UI/ecom/Profile/Bloc/profile_State.dart';
import 'package:flutter_ecom/data/remote/helper/api_helper.dart';
import 'package:flutter_ecom/utils/constants/app_urls.dart';

class ProfileBloc extends Bloc<ProfileEvents, ProfileStates> {
  ApiHelper apiHelper;

  ProfileBloc({required this.apiHelper}) : super(ProfileInitialState()) {
    on<FetchUserDetails>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        var res = await apiHelper.postApi(url: AppUrls.fetchUserProfile);
        if (res["status"]) {
          emit(ProfileSuccessState(userData: res["data"]));
        } else {
          emit(ProfileFailureState(errorMsg: res["message"]));
        }
      } catch (e) {
        emit(ProfileFailureState(errorMsg: e.toString()));
      }
    });
  }
}
