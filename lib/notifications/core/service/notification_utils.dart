import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:app_chat_firebase/notifications/domain/entity/notification_entity.dart';
import 'package:flutter/cupertino.dart';

class NotificationsUtils {
  static  onNotificationTab({required BuildContext context,
  required NotificationEntity notificationEntity,
  bool markAsRead = false}){
    if (markAsRead){
      logger.i(markAsRead);
    }
    logger.i(notificationEntity);
  }
}