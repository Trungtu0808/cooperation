// ignore_for_file: constant_identifier_names, duplicate_ignore

import 'package:app_chat_firebase/import_file/import_all.dart';
part 'notification_enum.g.dart';
// ignore: constant_identifier_names

@JsonEnum(alwaysCreate: true)
enum NotificationsTypes {
  @JsonValue(0)
  notify,
  @JsonValue(1)
  popup;

  static NotificationsTypes? fromAny(dynamic source) {
    return intEnumDecodeNullableAny(enumValues: _$NotificationsTypesEnumMap, source: source);
  }
}

enum NotificationsActionsTypes {
  @JsonValue("0")
  NOTIFY_ACTION_LOGIN('0'),
  @JsonValue("1")
  NOTIFY_ACTION_SIGN_UP('1'),
  @JsonValue("2")
  NOTIFY_ACTION_CHAT('2'),
  @JsonValue("3")
  NOTIFY_ACTION_UNKNOWN('3');

  const NotificationsActionsTypes(this.value);

  final String value;

}
