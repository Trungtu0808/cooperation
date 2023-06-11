import 'package:app_chat_firebase/data/device/device_repo.dart';
import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:app_model/app_model_all_file.dart';
import 'package:app_model/features/auth/resp/signed_in_data.dart';
import 'package:flutter/cupertino.dart';

part 'auth_event.dart';
part 'auth_state.dart';

typedef OnAuthError = Function(String errorMessage);

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required UserSecureStorage userSecureStorage,
    this.onAuthError,
  })  : _userSecureStorage = userSecureStorage,
        super(AuthInitialState()) {
    on<AuthSignInSuccessEvent>((event, emit) async {
      await _userSecureStorage.setSignedInData(event.signedInData);
      emit(AuthenticatedState(authenticatedType: AuthenticatedType.signIn, signedInData: event.signedInData,
      startRoute: _startRoute));
      _startRoute = null;
    });
    on<AuthSignUpSuccessEvent>((event, emit) async {
      await _userSecureStorage.setSignedInData(event.signedInData);
      emit(AuthenticatedState(
        authenticatedType: AuthenticatedType.signUp,
        signedInData: event.signedInData,
        startRoute: _startRoute,
      ));
      _startRoute = null;
    });
    on<AuthFirstLoadUserEvent>(_onFirstLoadAuthEvent);
    on<AuthSignOutEvent>((event, emit) => _onSignOut(event, emit));
  }

  late final UserSecureStorage _userSecureStorage;

  //final _authRepo = Get.find<AuthRepo>();
  final _firebase = Get.find<FireBaseAuthRepo>();
  final _deviceRepo = Get.find<DeviceRepo>();

  final OnAuthError? onAuthError;
  RouteData? _startRoute;

  void _onSignOut(event, emit) async {
    try {
      await _signOut();
      emit(UnauthenticatedState());
    } catch (e) {
      if (e is DioException) {
        emit(UnauthenticatedState());
        return;
      }
      onAuthError?.call(e.toString().tr());
    }
  }

  FutureOr<void> _onFirstLoadAuthEvent(
    AuthFirstLoadUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final signInData = _userSecureStorage.signedInData;
      if (signInData == null) {
        emit(UnauthenticatedState());
      } else {
        emit(AuthenticatedState(
          authenticatedType: AuthenticatedType.normal,
          signedInData: signInData,
        ));
      }
      //await Get.find<UserR>()
    } catch (e) {
      logger.e(e);
      emit(UnauthenticatedState(errorMsg: e.getServerErrorMsg()));
    }
  }

  Future _signOut() async {
    await _firebase.logOut();
    await _removeLocalReference();

  }
  Future _removeLocalReference() async{
    await _userSecureStorage.clear();
    _deviceRepo.removeToken();
  }
}
