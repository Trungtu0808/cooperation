import 'package:app_chat_firebase/import_file/import_all.dart';

class DatabaseServices {
  DatabaseServices({this.uid,});

  final String? uid;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection(AppConstant.databaseUserName);

  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection(AppConstant.databaseGroupName);

  Future updateUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "profilePic": "",
      "Groups": [],
      "uid": uid,
    });
  }
}
