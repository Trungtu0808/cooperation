import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:app_model/features/auth/req/sign_up_req.dart';

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

  Future<void> firebaseRegisterData(SignUpReq signUp) async {
    try {
      final data = await _authServices.registerUserWithEmailAndPassword(
        signUp.fullName ?? '',
        signUp.email ?? '',
        signUp.password ?? '',
      );
      return Future.value(data);
    } on FirebaseAuthException catch (e) {
      return Future.error(e.code ?? '');
    }
  }
}
