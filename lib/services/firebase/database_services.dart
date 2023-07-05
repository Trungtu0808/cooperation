import 'package:app_chat_firebase/data/device/device_repo.dart';
import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:app_model/features/auth/resp/sign_in_data_firestore.dart';

class DatabaseServices {
  DatabaseServices({
    this.uid,
  });

  final String? uid;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection(AppConstant.databaseUserName);

  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection(AppConstant.databaseGroupName);

  Future updateUserData({
    required SignInDataFirestore signInDataFirestore,
  }) async {
    final fcmTokenReq = await Get.find<DeviceRepo>().getFCMTokenReq();
    final checkToken = await _checkToken(
      token: fcmTokenReq.deviceToken,
      email: signInDataFirestore.signedInData?.email,
    );
    return await userCollection.doc(uid).set(signInDataFirestore
        .copyWith(
          fcmTokenReq: fcmTokenReq,
          signedInData: signInDataFirestore.signedInData?.copyWith(
            deviceToken: fcmTokenReq.deviceToken,
          ),
          uid: uid,
        )
        .toJson());
  }

  Future<SignInDataFirestore?> gettingEmailData(String? email) async {
    SignInDataFirestore? signInDataFirestore;
    await userCollection.doc(uid).collection('signedInData').where("email", isEqualTo: email).get();
    await userCollection.doc(uid).get().then((value) {
      final firestore = value.data() as Map<String, dynamic>;
      signInDataFirestore = SignInDataFirestore.fromJson(firestore);
    }).catchError((onError) {
      return null;
    });
    return signInDataFirestore;
  }

  Future<bool> _checkToken({
    String? token,
    String? email,
  }) async {
    final firestore = await gettingEmailData(email);
    if (firestore == null) {
      return false;
    }
    return firestore.fcmTokenReq?.deviceToken == token;
  }
}
