import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:app_model/app_model_all_file.dart';

class RepoError implements Exception {
  final String errorMsg;

  RepoError(this.errorMsg);
}

extension DioErrorExtend on Object? {
  String getServerErrorMsg(){
    final error = this;
    if (error is RepoError) {
      return (this as RepoError).errorMsg;
    }
    if (error is DioException){
      if (error.response?.statusCode == 401){
        return 'tokenExpired'.tr();
      }
      var errorCode = error.response?.data["errorCode"] as String?;
      if (errorCode != null){
        return errorCode.tr();
      }
      if (error.type == DioExceptionType.unknown){
        return 'noInternet'.tr();
      }
    }
    return 'errorPleaseRetry'.tr();
  }
}