import 'package:app_model/app_model_all_file.dart';

part 'signed_in_data.g.dart';

@JsonSerializable()
class SignedInData {

  final String? email;
  final String? fullName;
  final String? password;
  @JsonKey(name: 'Groups')
  final List<Map<String, dynamic>>? groups;

  SignedInData({this.email, this.fullName, this.password, this.groups});

  factory SignedInData.fromJson(Map<String, dynamic> json) => _$SignedInDataFromJson(json);
}