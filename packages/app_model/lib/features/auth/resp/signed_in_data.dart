import 'package:app_model/app_model_all_file.dart';

part 'signed_in_data.g.dart';

@JsonSerializable()
class SignedInData {
  final String? email;
  final String? fullName;
  final String? password;
  @JsonKey(name: 'Groups')
  final List<Map<String, dynamic>>? groups;
  final String? uid;

  SignedInData({
    this.email,
    this.fullName,
    this.password,
    this.groups,
    this.uid,
  });

  factory SignedInData.fromJson(Map<String, dynamic> json) => _$SignedInDataFromJson(json);

  SignedInData copyWith({
    String? email,
    String? fullName,
    String? password,
    String? uid,
  }) {
    return SignedInData(
      email: email ?? this.email,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
        uid : uid ?? this.uid,
    );
  }
}
