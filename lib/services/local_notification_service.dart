import 'dart:convert';
import 'dart:io';

import 'package:app_chat_firebase/import_file/import_all.dart';

const _iconLocation = '@mipmap/ic_launcher';
const _notificationSound = 'notification_sound';
const _defaultChannelId = 'high_importance_channel';
const _defaultChannelName = 'High Importance Notifications';

class LocalNotificationService {
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  AndroidNotificationChannel? channel;

  FutureOr<void> init({
    required NotificationPressedCallBack notificationPressedCallBack,
  }) async {
    // await _enableAlwaysHeadUpMessageIOS();
    await _initFlutterLocalNotificationPlugin(
      onPressedCallback: notificationPressedCallBack,
    );
    await _setupChannelForAndroid();
  }

  ///
  /// Init flutter_local_notifications for local notification
  ///
  Future<void> _initFlutterLocalNotificationPlugin(
      {required NotificationPressedCallBack onPressedCallback}) async {
    // Android Setting
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(_iconLocation);
    // IOS Setting
    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    // Combine
    const InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Handle when FlutterLocalNotificationPlugin notification is clicked
    flutterLocalNotificationsPlugin?.initialize(initializationSettings,
        //     onSelectNotification: (String? payload) async {
        //   if (payload != null) {
        //     try {
        //       final payloadJson = await jsonDecode(payload);
        //       onPressedCallback.call(payloadJson);
        //     } catch (e, trace) {
        //       logger.e(e.toString(), e, trace);
        //     }
        //   }
        // }
        onDidReceiveNotificationResponse: (
      NotificationResponse notificationResponse,
    ) async {
      try {
        if (notificationResponse.payload != null) {
          final payloadJson = await jsonDecode(notificationResponse.payload!);
          onPressedCallback.call(payloadJson);
        }
      } catch (e, trace) {
        logger.e(e.toString(), e, trace);
      }
    });
  }

  void showMessageHeadUpForeground({
    int? id,
    RemoteMessage? message,
  }) {
    logger.i('_showMessageHeadUp');
    if (message != null) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      NotificationDetails? notificationDetails;
      if (Platform.isAndroid && android != null && channel != null) {
        notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
              channel?.id ?? _defaultChannelId, channel?.name ?? _defaultChannelName,
              channelShowBadge: true,
              // !!! also set the sound in the channel - For Android 8.0 or newer, this (sound) is tied to the specified channel
              sound: const RawResourceAndroidNotificationSound(_notificationSound),
              playSound: true),
        );
      } else if (Platform.isIOS) {
        notificationDetails = const NotificationDetails(
          iOS: DarwinNotificationDetails(
            presentBadge: true,
            // badgeNumber: 3,
            presentAlert: true,
            presentSound: true,
            sound: '$_notificationSound.wav',
          ),
        );
      }
      var title = notification?.title ??
          getStringFromLocKey(notification?.titleLocKey, notification?.titleLocArgs);
      var body = notification?.body ??
          getStringFromLocKey(notification?.bodyLocKey, notification?.bodyLocArgs);
      flutterLocalNotificationsPlugin?.show(
        id ?? notification.hashCode,
        title,
        body,
        notificationDetails,
        payload: jsonEncode(message.data),
      );
    }
  }

  Future<void> _setupChannelForAndroid() async {
    if (Platform.isAndroid) {
      channel = const AndroidNotificationChannel(
        _defaultChannelId,
        // id string - create also in Android Manifest
        _defaultChannelName,
        importance: Importance.max,
        playSound: true,
        sound: RawResourceAndroidNotificationSound(_notificationSound),
      );
      await flutterLocalNotificationsPlugin
          ?.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel!);
    }
  }

  String? getStringFromLocKey(String? locKey, List<String>? locArgs) {
    String? rs;
    if (locKey.isNotNullOrEmpty()) {
      rs = locKey?.tr();

      String replaceCode = Platform.isIOS ? '%@' : r'%1$s';
      locArgs?.forEach((arg) {
        rs = rs?.replaceFirst(replaceCode, arg);
      });
    }
    return rs;
  }

  Future<void> showSimpleNotification({int? id, String? title, required String body}) async {
    showMessageHeadUpForeground(
      id: 999555,
      message: RemoteMessage(
        notification: RemoteNotification(
          title: title,
          body: body,
        ),
      ),
    );
    await flutterLocalNotificationsPlugin?.cancel(999555);
  }

  Future<void> showLocalSimpleNotification({int? id, String? title, required String body}) async {
    NotificationDetails? notificationDetails;

    if (Platform.isAndroid && channel != null) {
      notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            channel?.id ?? _defaultChannelId, channel?.name ?? _defaultChannelName,
            channelShowBadge: true,
            // !!! also set the sound in the channel - For Android 8.0 or newer, this (sound) is tied to the specified channel
            sound: const RawResourceAndroidNotificationSound(_notificationSound),
            playSound: true),
      );
    } else if (Platform.isIOS) {
      notificationDetails = const NotificationDetails(
        iOS: DarwinNotificationDetails(
          presentBadge: true,
          // badgeNumber: 3,
          presentAlert: true,
          presentSound: true,
          sound: '$_notificationSound.wav',
        ),
      );
    }

    await flutterLocalNotificationsPlugin?.show(
      10000,
      title,
      body,
      notificationDetails,
    );
    // await flutterLocalNotificationsPlugin?.cancel(10000);
  }
}
