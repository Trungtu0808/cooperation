import 'package:base_component/import_all.dart';

import 'notification_enum.dart';
// import 'package:copy_with_extension/copy_with_extension.dart';

part 'notification_payload.g.dart';

abstract class NotificationPayload {
  NotificationPayload({this.notificationsTypes, this.notificationsActionsTypes});

  final NotificationsActionsTypes? notificationsActionsTypes;

  @JsonKey(fromJson: NotificationsTypes.fromAny)
  final NotificationsTypes? notificationsTypes;

  static NotificationPayload? fromJson(Map<String, dynamic> json) {
    final actionsTypes = json["actionsTypes"] as String?;
    if (_isSignInAction(actionType: actionsTypes)) {
      return NotificationSignInPayLoad.fromJson(json);
    }
    return null;
  }

  static bool _isSignInAction({required String? actionType}) {
    return NotificationsActionsTypes.NOTIFY_ACTION_LOGIN.value == actionType;
  }
}

@JsonSerializable()
class NotificationSignInPayLoad extends NotificationPayload {
  NotificationSignInPayLoad({this.title, this.message, this.body});

  final String? title;
  final String? message;
  final String? body;

  factory NotificationSignInPayLoad.fromJson(Map<String, dynamic> json) =>
      _$NotificationSignInPayLoadFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationSignInPayLoadToJson(this);
}
