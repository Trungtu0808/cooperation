import 'dart:convert';
import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:app_model/enums.dart';
import 'package:app_model/features/auth/req/signed_req.dart';
import 'package:app_model/features/auth/resp/sign_in_data_firestore.dart';
import 'package:app_model/features/auth/resp/signed_in_data.dart';

class AuthServices {
  FireBaseAuthRepo get _firebaseAuth => Get.find<FireBaseAuthRepo>();

  /// login
  Future<SignedInData?> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {

      final userCredential = await _firebaseAuth.logInWithEmailAndPassword(email: email, password: password,);
      final uid = userCredential.user!.uid;

      final dataService = DatabaseServices(uid: uid);
      if (userCredential.user != null){
        var data = await dataService.gettingEmailData(email);
        dataService.updateUserData(signInDataFirestore: SignInDataFirestore().copyWith(
          signedInData: SignedInData().copyWith(email: email, password: password, uid: uid,
          signUpTypes: SignUpTypes.EMAIL_SIGN_UP_TYPES),
        )).then((value) => data = value);


        return data?.signedInData;
      }
      return null;
    } catch (e) {
      logger.e(e);
      if (e is LogInWithSocialFailure){
        return Future.error(e.message);
      }
      return Future.error(e);
    }
  }

  // register
  Future<UserCredential> registerUserWithEmailAndPassword({
    required SignedReq signedReq,
    SignUpTypes? signUpTypes,
  }) async {
    try {
      // if (signedReq.email == null) {
      //   return Future.error('error');
      // }
      String digest =
          sha1.convert(utf8.encode("cooperation")).bytes.mapAsList((item) => item).toString();
      final userCredential = (await _firebaseAuth.signUp(
        email: signedReq.email,
        password: signedReq.password ?? digest,
      ));
      if (userCredential.user == null) {
        return Future.error('error');
      }
      final signedData = SignedInData(
        email: signedReq.email,
        password: signedReq.password,
        fullName: signedReq.fullName,
        uid: userCredential.user!.uid,
        signUpTypes: signUpTypes ?? SignUpTypes.EMAIL_SIGN_UP_TYPES
      );

      await DatabaseServices(uid: userCredential.user?.uid).updateUserData(
        signInDataFirestore: SignInDataFirestore().copyWith(
          signedInData: signedData,
          profilePic: userCredential.user?.photoURL,
        ),
      );
      return Future.value(userCredential);
    } on FirebaseAuthException catch (e) {
      logger.e(e);
      return Future.error(e.code);
    } catch (e) {
      logger.e(e);
      if (e is SignUpWithEmailAndPasswordFailure) {
        return Future.error(e.message);
      }
      return Future.error(e);
    }
  }
}
