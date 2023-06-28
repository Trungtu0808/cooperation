// ignore_for_file: constant_identifier_names

import 'app_model_all_file.dart';

//part 'enums.g.dart';

enum AccountTypes {
  @JsonValue(0)
  BUILTIN_ACC_TYPE(0),
  @JsonValue(1)
  GOOGLE_ACC_TYPE(1),
  @JsonValue(2)
  FACEBOOK_ACC_TYPE(2),
  @JsonValue(3)
  APPLE_ACC_TYPE(3),
  @JsonValue(4)
  OTHER_ACC_TYPE(4);

  const AccountTypes(this.value);
  final int value;
}

enum SignUpTypes {
  @JsonValue(0)
  SOCIAL_SIGN_UP_TYPES(0),
  @JsonValue(1)
  EMAIL_SIGN_UP_TYPES(1);

  const SignUpTypes(this.value);
  final int value;
}