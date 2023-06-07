import 'package:app_chat_firebase/features/screens/auth/social_auth/social_auth_state.dart';
import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:app_model/enums.dart';
import 'package:app_model/features/auth/resp/signed_in_data.dart';
import 'package:flutter/cupertino.dart';

class SocialAuthCubit extends Cubit<SocialAuthState> {
  SocialAuthCubit() : super(Initializing());

  final _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn.standard();
  final _firebaseAuthRepo = Get.find<FireBaseAuthRepo>();
  void init() {}

  void signInWithSocialAccount(AccountTypes accountTypes) async {
    emit(SocialSigningInState());
    final googleUser = _googleSignIn.currentUser;
    if (googleUser != null) {
      _googleSignIn.signOut();
    }
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      _firebaseAuth.signOut();
    }
    //UserCredential? credential;
    LoginSocialResult? loginSocialResult;
    String? fullName;
    try {
      switch (accountTypes) {
        case AccountTypes.BUILTIN_ACC_TYPE:
          // TODO: Handle this case.
          break;
        case AccountTypes.GOOGLE_ACC_TYPE:
          //credential = await _sigInWithGoogle();
          loginSocialResult = await _firebaseAuthRepo.signInWithGoogle();
          break;
        case AccountTypes.FACEBOOK_ACC_TYPE:
          // TODO: Handle this case.
          break;
        case AccountTypes.APPLE_ACC_TYPE:
          // TODO: Handle this case.
          break;
        case AccountTypes.OTHER_ACC_TYPE:
          // TODO: Handle this case.
          break;
        default:
          throw Exception("${accountTypes.runtimeType} is not support");
      }
      //final token = await credential?.user?.getIdToken();
      final token = loginSocialResult?.userCredential?.user?.getIdToken();
      if (token == null) {
        emit(SocialSignInCanceled(msg: token.getServerErrorMsg()));
        return;
      }
      debugPrint("$loginSocialResult");
      emit(SocialSignInSuccessful(SignedInData(
        email: loginSocialResult?.email,
        fullName: loginSocialResult?.displayName,
        uid: loginSocialResult?.socialId,
      )));
    } catch (e) {
      logger.e(e);
      if ([
        ServiceErrorCode.ACCOUNT_EXITS_WITH_DIFFERENT_CREDENTIAL,
        ServiceErrorCode.INVALID_CREDENTIAL,
      ].contains(e.toString())) {
        emit(SocialAuthError(e.toString().tr()));
      } else if (e is LogInWithSocialFailure) {
        emit(SocialSignInCanceled(msg: e.message.tr()));
      } else if (e is LogInWithSocialCancel) {
        emit(SocialSignInCanceled(msg: e.getServerErrorMsg()));
      }
    }
  }

  Future<UserCredential?> _sigInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser?.authentication;
    if (googleAuth == null) {
      return null;
    }
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    return await _firebaseAuth.signInWithCredential(credential);
  }
}
