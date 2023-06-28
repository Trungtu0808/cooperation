
import 'package:app_model/app_model_all_file.dart';
part 'sign_up_req.g.dart';
@JsonSerializable()
class SignUpReq {
  final String? fullName;
  final String? password;
  final String email;

  SignUpReq({this.fullName, this.password, required this.email,});

  Map<String, dynamic> toJson() => _$SignUpReqToJson(this);
}