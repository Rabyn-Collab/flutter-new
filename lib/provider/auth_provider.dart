import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/model/common_state.dart';
import 'package:flutternew/services/auth_service.dart';
import 'package:image_picker/image_picker.dart';



final authProvider = StateNotifierProvider<AuthProvider,CommonState>((ref) => AuthProvider(
    CommonState(
  isLoad: false,
  isSuccess: false,
  isError: false,
  errText: ''
)));

class AuthProvider extends StateNotifier<CommonState>{
  AuthProvider(super.state);


  Future<void> userLogin(
      {required String email, required String password}) async {
    state = state.copyWith(errText: '',isError: false, isSuccess: false, isLoad: true);
    final response = await AuthService.userLogin(email: email, password: password);
    response.fold((l) {
      state = state.copyWith(errText: l,isError: true, isSuccess: false, isLoad: false);
    }, (r) {
      state = state.copyWith(errText: '',isError: false, isSuccess: r, isLoad: false);
    });
  }

  Future<void> userSignUp(
      {
        required String email,
        required String password,
        required String username,
        required XFile image
      }) async {
    state = state.copyWith(errText: '',isError: false, isSuccess: false, isLoad: true);
    final response = await AuthService.userSignUp(
        email: email, password: password, username: username, image: image);
    response.fold((l) {
      state = state.copyWith(errText: l,isError: true, isSuccess: false, isLoad: false);
    }, (r) {
      state = state.copyWith(errText: '',isError: false, isSuccess: r, isLoad: false);
    });
  }



  Future<void> userLogOut() async {
    state = state.copyWith(errText: '',isError: false, isSuccess: false, isLoad: true);
    final response = await AuthService.userLogOut();
    response.fold((l) {
      state = state.copyWith(errText: l,isError: true, isSuccess: false, isLoad: false);
    }, (r) {
      state = state.copyWith(errText: '',isError: false, isSuccess: r, isLoad: false);
    });
  }





}