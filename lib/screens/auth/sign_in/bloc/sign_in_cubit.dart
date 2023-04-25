import 'package:app_chat_firebase/import_file/import_all.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitState());

  void signUpWithEmail({
    required String userName,
    required String password,
    required String email,
  }) async{
    try{
      //await
    }on FirebaseAuthException catch (e){
      emit(SignInErrorState(e.message ?? ''));
    }
  }
}
