
import 'package:app_model/app_model_all_file.dart';
part 'sign_in_req.g.dart';
@JsonSerializable()
class SignInReq {
  final String? fullName;
  final String? password;
  final String? email;

  SignInReq({this.fullName, this.password, this.email,});

  Map<String, dynamic> toJson() => _$SignInReqToJson(this);
}