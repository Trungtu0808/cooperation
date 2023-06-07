part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthSignInSuccessState extends AuthState {}

class AuthenticatedState extends AuthState {
  AuthenticatedState(
    this.authenticatedType,
    //this.shouldUpdateProfile,
    this.signedInData,
    this.startRoute,
  );

  final AuthenticatedType authenticatedType;
  //final bool shouldUpdateProfile;
  final SignedInData signedInData;
  final RouteData? startRoute;
}

class UnauthenticatedState extends AuthState{}

enum AuthenticatedType {
  signIn,
  signUp,
  normal,
}
