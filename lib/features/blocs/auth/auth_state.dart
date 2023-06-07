part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

//class AuthSignInSuccessState extends AuthState {}

class AuthenticatedState extends AuthState {
  AuthenticatedState({
    required this.authenticatedType,
    //this.shouldUpdateProfile,
    required this.signedInData,
    this.startRoute,
  });

  final AuthenticatedType authenticatedType;
  //final bool shouldUpdateProfile;
  final SignedInData signedInData;
  final RouteData? startRoute;
}

class UnauthenticatedState extends AuthState{
  UnauthenticatedState({this.errorMsg});

  final String? errorMsg;
}

enum AuthenticatedType {
  signIn,
  signUp,
  normal,
}
