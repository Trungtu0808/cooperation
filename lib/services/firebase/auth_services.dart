import 'dart:convert';
import 'package:app_chat_firebase/data/device/device_repo.dart';
import 'package:app_chat_firebase/import_file/import_all.dart';
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
          signedInData: SignedInData().copyWith(email: email, password: password, uid: uid),
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
    required SignedInData signedInData,
  }) async {
    try {
      if (signedInData.email == null) {
        return Future.error('error');
      }
      String digest =
          sha1.convert(utf8.encode("cooperation")).bytes.mapAsList((item) => item).toString();
      final userCredential = (await _firebaseAuth.signUp(
        email: signedInData.email!,
        password: signedInData.password ?? digest,
      ));
      if (userCredential.user == null) {
        return Future.error('error');
      }


      await DatabaseServices(uid: userCredential.user?.uid).updateUserData(
        signInDataFirestore: SignInDataFirestore().copyWith(
          signedInData: signedInData.copyWith(uid: userCredential.user?.uid),
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
