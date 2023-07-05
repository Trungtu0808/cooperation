import 'package:app_chat_firebase/data/device/device_repo.dart';
import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:app_model/enums.dart';
import 'package:app_model/features/auth/req/signed_req.dart';
import 'package:app_model/features/auth/resp/signed_in_data.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitState());

  final _authRepo = Get.find<AuthRepo>();
  final _userSecureStorage = UserSecureStorage();

  void signUpWithEmail({
    required String userName,
    required String password,
    required String email,
    SignUpTypes? signUpTypes,
  }) async {
    try {
      emit(SigningInState());
      final signUp = SignedReq(
        fullName: userName,
        password: password,
        email: email,
      );
      final userCredential = await _authRepo.firebaseRegisterData(signUp: signUp, );
      final fcmTokenReq = await Get.find<DeviceRepo>().getFCMTokenReq();
      final signedInData = SignedInData(
        email: email,
        password: password,
        fullName: userName,
        uid: userCredential.user?.uid,
        signUpTypes: signUpTypes ?? SignUpTypes.EMAIL_SIGN_UP_TYPES,
        deviceToken: fcmTokenReq.deviceToken,
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
        signUpTypes: SignUpTypes.EMAIL_SIGN_UP_TYPES,
      );
      emit(SignInSuccessState(signedInData));
    }catch(e){
      emit(SignInErrorState(e.toString().tr()));
    }
  }
}
