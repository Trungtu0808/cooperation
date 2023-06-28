part of'notification_model.dart';

extension NotificationManager on NotificationModel{
  NotificationEntity toEntity(){
    return NotificationEntity(
      title: title,
      subtitle: subTitle,
      actionTypes: actionTypes,
    );
  }
}