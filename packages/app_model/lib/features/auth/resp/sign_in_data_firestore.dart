import 'package:app_model/features/auth/resp/signed_in_data.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_in_data_firestore.g.dart';

@JsonSerializable()
@CopyWith()
class SignInDataFirestore {
  SignInDataFirestore({this.signedInData, this.fcmTokenReq, this.uid, this.profilePic});

  final SignedInData? signedInData;
  final FCMTokenReq? fcmTokenReq;
  final String? uid;
  final String? profilePic;

  factory SignInDataFirestore.fromJson(Map<String, dynamic> json) =>
      _$SignInDataFirestoreFromJson(json);

  Map<String, dynamic> toJson() => {
        if (signedInData != null) "signedInData": signedInData?.toJson(),
        if (fcmTokenReq != null) "fcmTokenReq": fcmTokenReq?.toJson(),
        "uid": uid,
        if (profilePic != null) "profilePic": profilePic,
      };
  // Map<String, dynamic> toJson() =>
  // _$SignInDataFirestoreToJson(this);
}
