//import 'package:dr_gold/service/call_kit.dart';
import 'dart:io';

import 'package:app_chat_firebase/import_file/import_all.dart';

/// TODO: SETUP
/// 1. Add this to manifest
/// <meta-data
///      android:name="com.google.firebase.messaging.default_notification_channel_id"
///      android:value="high_importance_channel" />
/// 2. IOS: https://firebase.flutter.dev/docs/messaging/apple-integration
/// 3. If use IOS lower IOS 10 then add onDidReceiveLocalNotification for flutter_local_notifications
/// 4. Subscribe to  Global Topics
///


typedef NotificationPressedCallBack = void Function(
    Map<String, dynamic>? jsonData);

typedef FilterMessage = FilterMessageResult Function({
  Map<String, dynamic>? data,
  RemoteNotification? notification,
});

enum FilterMessageResult {
  consumed,
  skipped,
}

/// This must be top-level method
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  // In here you can perform logic such as HTTP requests, perform IO operations (e.g. updating local storage)
  logger.i("Handling a background message: ${message.notification?.title}");

  final data = message.data;
  final callId = data['callId'];
  if (callId != null) {
    //CallKit.handleCallkit(data);
  }
}

class FirebaseNotificationService {
  FirebaseNotificationService._();

  static final FirebaseNotificationService _instance =
      FirebaseNotificationService._();

  static FirebaseNotificationService get instance {
    return _instance;
  }


  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late final LocalNotificationService _localNotification;

  Future<void> init({
    required NotificationPressedCallBack notificationPressedCallBack,
    required FilterMessage filterMessage,
    required LocalNotificationService localNotification
  }) async {
    _localNotification = localNotification;
    await _requestPermission();

    await _setupMessageListener(filterMessage: filterMessage);
    await setupInteractedMessage(callBack: notificationPressedCallBack);

    _firebaseMessaging.getToken().then((value) {
      logger.i('FirebaseMessaging Token: ${value?.toString() ?? ''}');
    });
  }

  Future<String?> getFCMToken() {
    return _firebaseMessaging.getToken();
  }

  Future<void> _requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied ||
        settings.authorizationStatus == AuthorizationStatus.notDetermined) {
      logger
          .e('PushNotification: User declined or has not accepted permission');
    }
  }

  
  Future<void> _setupMessageListener({
    required FilterMessage filterMessage,
  }) async {
    // On Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      logger.i('onMessage');
      _logMessage(message);

      var result = filterMessage(
        data: message.data,
        notification: message.notification,
      );
      if (result == FilterMessageResult.consumed) {
        logger.i('Message not show because filtered');
        return;
      }
      _localNotification.showMessageHeadUpForeground(
        message: message,
      );
    });

    // On Background/Terminated
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }


  Future<void> setupInteractedMessage(
      {required NotificationPressedCallBack callBack}) async {
    // Get any messages which caused the application to open from a terminated state.
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      _logMessage(message);
      _onMessageClick(message, callBack);
    });

    // Also handle any interaction when the app is in the background via a Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      logger.i('onMessageOpenedApp ', message);
      _onMessageClick(message, callBack);
    });
  }

  Future<void> subscribeToTopic(String topicName) async {
    _firebaseMessaging.subscribeToTopic(topicName);
  }

  void _onMessageClick(
      RemoteMessage? message, NotificationPressedCallBack callBack) {
    if (message == null) {
      return;
    }

    logger.i('_onMessageClick ', message);
    callBack.call(message.data);
  }

  void _logMessage(RemoteMessage? message) {
    if (message == null) {
      return;
    }

    logger.i('Tag: FirebaseMessaging \n'
        'getInitialMessage:\n'
        '-- data: ${message.data.toString()}\n'
        '-- messageId: ${message.messageId}\n'
        '-- title: ${message.notification?.title}\n'
        '-- messageType: ${message.messageType}\n'
        '-- notification: ${message.notification}\n'
        '-- notification-body: ${message.notification?.body.toString()}\n'
        '-- from: ${message.from}');
  }

  Future<void> hideAllNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: false,
      badge: false,
      sound: false,
    );
  }

  Future<void> enableAllNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void removeToken() {
    _firebaseMessaging.deleteToken();
    _firebaseMessaging.getToken();
  }

  ///
  /// App in Foreground -> this will show message both on the navigation and on the screen as well in
  ///
  Future<void> _enableAlwaysHeadUpMessageIOS() async {
    if (Platform.isIOS) {
      _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );
    }
  }
}
