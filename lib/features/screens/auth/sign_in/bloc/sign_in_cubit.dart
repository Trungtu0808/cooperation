import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:app_model/features/auth/req/sign_up_req.dart';
import 'package:app_model/features/auth/resp/signed_in_data.dart';
import 'package:flutter/cupertino.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitState());

  final _authRepo = Get.find<AuthRepo>();
  final _userSecureStorage = UserSecureStorage();

  void signUpWithEmail({
    required String userName,
    required String password,
    required String email,
  }) async {
    try {
      emit(SigningInState());
      final signUp = SignedInData(
        fullName: userName,
        password: password,
        email: email,
      );
      final userCredential = await _authRepo.firebaseRegisterData(signUp: signUp, );
      final signedInData = SignedInData(
        email: email,
        password: password,
        fullName: userName,
        uid: userCredential.user?.uid,
      );

      emit(SignUpSuccessState(signedInData));
    } catch (e) {
      emit(SignInErrorState(e.toString().tr()));
    }
  }

  void signInWithEmail({required String email, required String password,}) async {
    try{
      emit(SigningInState());
      final logIn = await _authRepo.loginWithEmailPassword(email: email, password: password);
      final signedInData = SignedInData(
        email: email,
        password: password,
        fullName: logIn?.fullName,
        uid: logIn?.uid,
      );
      emit(SignInSuccessState(signedInData));
    }catch(e){
      emit(SignInErrorState(e.toString().tr()));
    }
  }
}
