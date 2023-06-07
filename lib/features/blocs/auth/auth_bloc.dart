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
    });
    on<AuthSignUpSuccessEvent>((event, emit) async {
      await _userSecureStorage.setSignedInData(event.signedInData);
      emit(AuthenticatedState(AuthenticatedType.signUp, event.signedInData, _startRoute,));
      _startRoute = null;

    });
    on<AuthSignOutEvent>((event, emit) => _onSignOut(event, emit));
  }

  late final UserSecureStorage _userSecureStorage;

  //final _authRepo = Get.find<AuthRepo>();
  final _firebase = Get.find<FireBaseAuthRepo>();

  final OnAuthError? onAuthError;
  RouteData? _startRoute;

  void _onSignOut(event, emit)async{
    try{
      await _signOut();
      emit(UnauthenticatedState());
    }catch(e){
      // ignore: deprecated_member_use
      if (e is DioError){
        emit(UnauthenticatedState());
        return;
      }
      onAuthError?.call(e.toString().tr());
    }
  }

  Future _signOut()async{
    await _firebase.logOut();
  }
}
