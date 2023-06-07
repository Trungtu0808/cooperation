import 'package:app_chat_firebase/import_file/import_all.dart';

class AuthServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // login

  // register
  Future registerUserWithEmailAndPassword(
    String fullName,
    String email,
    String password,
  ) async {
    //try {
      final user = (await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;

      if (user != null) {
        await DatabaseServices(uid: user.uid).updateUserData(
          fullName: fullName,
          email: email,
          password: password,
        );
        return true;
      }
    // } on FirebaseAuthException catch (e) {
    //   logger.e(e);
    //   return e.message;
    // }
  }
}
