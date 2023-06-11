import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:app_model/features/auth/resp/signed_in_data.dart';

class DeviceRepo {
  DeviceRepo();

  Future<FCMTokenReq> getFCMTokenReq()async{
    try{
      var deviceID = await AppUtils.getDeviceID();
      var fcmToken = await FirebaseNotificationService.instance.getFCMToken();
      return Future.value(FCMTokenReq(
        deviceID: deviceID,
        deviceToken: fcmToken,
        deviceIosID: await getIosVoipToken(),
        type: 'MOBILEAPP'
      ));
    }catch(e){
      logger.e(e);
      return Future.error(e);
    }
  }

  Future<String?> getIosVoipToken() async {
    // final token = await FlutterCallkitIncoming.getDevicePushTokenVoIP();
    // if (token is String && token.isNotEmpty) {
    //   // is Ios device
    //   return token;
    // } else {
    //   // is Android device
       return null;
    // }
  }

  void removeToken(){
    return FirebaseNotificationService.instance.removeToken();
  }
}