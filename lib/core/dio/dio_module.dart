import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioModule extends DisposableInterface {

  DioModule({required this.baseUrl,required this.showLog,required this.userSecureStorage});

  final String baseUrl;
  final bool showLog;
  final UserSecureStorage userSecureStorage;

  static const authorizationKey = "Authorization";

  Dio? _dio;

  Dio get dio {
    if (_dio != null) {
      return _dio!;
    }
    logger.i('*** Dio Create');
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 20000),
      receiveTimeout: const Duration(seconds: 20000),
      sendTimeout: const Duration(seconds: 20000),
    );

    //Get data for mobile on serve
    _dio = Dio(options);

    if (showLog){
      _dio!.interceptors.add(PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
      ));
    }

    addTokenInterceptor();
    addRetryInterceptor();

    return _dio!;
  }

  void removeToken(){
    logger.i('*** DioModule.removeToken');
    dio.options.headers[authorizationKey] = null;
    dio.options.headers['token'] = null;
  }

  void addTokenInterceptor(){
    // Note: Do not use QueuedInterceptorsWrapper because it will block the refresh request api,
    // currently the only way to block all request is use difference instance of dio to call refresh api
    dio.interceptors.add(QueuedInterceptorsWrapper(
      onRequest: (options, handle) async{
        final token = userSecureStorage.token;
        logger.i('Token: $token');
        _setRequestOptionToken(options, token);
        return handle.next(options);
      },
      onError: (error, handle) async{
        final errorCode = error.getServerErrorMsg();
        if (error.response != null){
          if (error.response?.statusCode == 401){
            var oldToken = error.requestOptions.headers[authorizationKey];
            var token = 'Bearer ${userSecureStorage.token}';
            if (oldToken != token){
              var response = await _retryRequestResponse(error.requestOptions);
              if (response != null){
                return handle.resolve(response);
              }
            }
          }
        }
      }
    ));
  }
  void addRetryInterceptor(){
    // Add the interceptor
    dio.interceptors.add(RetryInterceptor(
      dio: dio,
      logPrint: print, // specify log function (optional)
      retries: 3, // retry count (optional)
      retryDelays: const [ // set delays between retries (optional)
        Duration(seconds: 1), // wait 1 sec before first retry
        Duration(seconds: 2), // wait 2 sec before second retry
        Duration(seconds: 3), // wait 3 sec before third retry
      ],
    ));
  }

  Future<Response<dynamic>?> _retryRequestResponse(RequestOptions options) async{
    var accessToken = userSecureStorage.token;
    if (accessToken!= null){
      _setRequestOptionToken(options, accessToken);
      return await dio.fetch(options);
    }
    return null;
  }
  void _setRequestOptionToken(RequestOptions options, String? token){
    options.headers[authorizationKey] = token != null ? 'Bearer + $token' : null;
    options.headers["token"] = token;
  }



  @override
  void onClose() {
    super.onClose();
    logger.i('**** Dio clear');
  }
}