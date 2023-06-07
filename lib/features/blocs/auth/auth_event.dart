part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthInitialEvent extends AuthEvent{}

class AuthSignOutEvent extends AuthEvent {}

class AuthFirstLoadUserEvent extends AuthEvent{
  // AuthFirstLoadUserEvent();
}

class AuthSignInSuccessEvent extends AuthEvent{

  AuthSignInSuccessEvent({required this.signedInData});

  final SignedInData signedInData;

}

class AuthSignUpSuccessEvent extends AuthEvent{

  AuthSignUpSuccessEvent({required this.signedInData});

  final SignedInData signedInData;

}
