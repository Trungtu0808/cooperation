import 'package:app_model/app_model_all_file.dart';
part 'signed_req.g.dart';

@JsonSerializable()
class SignedReq {
  final String? fullName;
  final String? password;
  final String email;

  SignedReq({
    this.fullName,
    this.password,
    required this.email,
  });

  Map<String, dynamic> toJson() => _$SignedReqToJson(this);

  SignedReq copyWith({
    String? fullName,
    String? password,
    String? email,
  }) {
    return SignedReq(
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      password: password ?? this.password,
    );
  }
}
