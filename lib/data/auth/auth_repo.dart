import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:app_model/enums.dart';
import 'package:app_model/features/auth/req/signed_req.dart';
import 'package:app_model/features/auth/resp/signed_in_data.dart';

class AuthRepo {
  late final FireBaseAuthRepo _fireBaseAuthRepo;
  late final AuthServices _authServices;

  AuthRepo({
    FireBaseAuthRepo? fireBaseAuthRepo,
    AuthServices? authServices,
  }) {
    _fireBaseAuthRepo = fireBaseAuthRepo ?? Get.find<FireBaseAuthRepo>();
    _authServices = authServices ?? Get.find<AuthServices>();
  }

  Future<UserCredential> firebaseRegisterData({required SignedReq signUp, SignUpTypes? signUpTypes}) async {
    try {
      final data = await _authServices.registerUserWithEmailAndPassword(
        signedReq: signUp,
      );
      return Future.value(data);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> checkIfEmailInUse(String email) async {
    try {
      return Future.value(_fireBaseAuthRepo.checkIfEmailInUse(email));
    } catch (e) {
      return false;
    }
  }

  Future<SignedInData?> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      return Future.value(_authServices.loginWithEmailPassword(
        email: email,
        password: password,
      ));
    } catch (e) {
      logger.e(e);
      return Future.error(e);
    }
  }
}
