import 'package:app_chat_firebase/features/screens/auth/social_auth/social_auth_state.dart';
import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:app_model/enums.dart';
import 'package:app_model/features/auth/resp/signed_in_data.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


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
    UserCredential? userCredential;
    String? fullName;
    try {
      switch (accountTypes) {
        case AccountTypes.BUILTIN_ACC_TYPE:
          // TODO: Handle this case.
          break;
        case AccountTypes.GOOGLE_ACC_TYPE:
          //credential = await _sigInWithGoogle();
          final loginSocialResult = await _firebaseAuthRepo.signInWithGoogle();
          userCredential = loginSocialResult?.userCredential;
          break;
        case AccountTypes.FACEBOOK_ACC_TYPE:
          final loginSocialResult = await _firebaseAuthRepo.signInWithFacebook();
          userCredential = loginSocialResult?.userCredential;
          break;
        case AccountTypes.APPLE_ACC_TYPE:
          //final credential = await AppleAuth.signInWithApple();
          final loginSocialResult = await _firebaseAuthRepo.signInWithApple();
          userCredential = loginSocialResult?.userCredential;
          break;
        case AccountTypes.OTHER_ACC_TYPE:
          // TODO: Handle this case.
          break;
        default:
          throw Exception("${accountTypes.runtimeType} is not support");
      }
      final token = userCredential?.user?.getIdToken();
      if (token == null) {
        emit(SocialSignInCanceled(msg: token.getServerErrorMsg()));
        return;
      }
      emit(SocialSignInSuccessful(SignedInData(
        email: userCredential?.user?.email,
        fullName: userCredential?.user?.displayName,
        uid: userCredential?.user?.uid,
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
      else if (e is AuthorizationErrorCode){
        emit(SocialSignInCanceled(msg: e.name.getServerErrorMsg()));
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

  Future<UserCredential?> _signWithFacebook() async {
    final result = await FacebookAuth.instance.login(permissions: ['public_profile']);
    if (result.status == LoginStatus.success) {
      final accessToken = result.accessToken!;
      final credential = FacebookAuthProvider.credential(accessToken.token);
      return _firebaseAuth.signInWithCredential(credential);
    }
    return null;
  }
}
