import 'package:app_model/app_model_all_file.dart';
import 'package:app_model/enums.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'signed_in_data.g.dart';

@JsonSerializable()
class SignedInData {
  final String? email;
  final String? fullName;
  final String? password;
  @JsonKey(name: 'Groups')
  final List<Map<String, dynamic>>? groups;
  final String? uid;
  @JsonKey(defaultValue: SignUpTypes.EMAIL_SIGN_UP_TYPES)
  final SignUpTypes? signUpTypes;
  final String? token;
  final String? deviceToken;

  SignedInData({
    this.email,
    this.fullName,
    this.password,
    this.groups,
    this.uid,
    this.signUpTypes,
    this.token,
    this.deviceToken,
  });

  factory SignedInData.fromJson(Map<String, dynamic> json) => _$SignedInDataFromJson(json);
  Map<String, dynamic> toJson() => _$SignedInDataToJson(this);

  SignedInData copyWith({
    String? email,
    String? fullName,
    String? password,
    String? uid,
    SignUpTypes? signUpTypes,
    List<Map<String, dynamic>>? groups,
    String? token,
    String? deviceToken,
  }) {
    return SignedInData(
      email: email ?? this.email,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
        uid : uid ?? this.uid,
      signUpTypes: signUpTypes ?? this.signUpTypes,
      groups: groups ?? this.groups,
      token: token?? this.token,
      deviceToken: deviceToken?? this.deviceToken,
    );
  }
}

@JsonSerializable(ignoreUnannotated: false)
class FCMTokenReq {
  @JsonKey(name: 'deviceID')
  final String? deviceID;
  @JsonKey(name: 'deviceToken')
  final String? deviceToken;
  @JsonKey(name: 'type')
  final String type;
  final String? deviceIosID;

  const FCMTokenReq({
    this.deviceID,
    this.deviceToken,
    required this.type,
    required this.deviceIosID,
  });

  factory FCMTokenReq.fromJson(Map<String, dynamic> json) =>
      _$FCMTokenReqFromJson(json);

  Map<String, dynamic> toJson() => _$FCMTokenReqToJson(this);
}
