part of 'sign_in_cubit.dart';
abstract class SignInState{}

class SignInInitState extends SignInState{}

class SigningInState extends SignInState{}

class SignInErrorState extends SignInState{
  SignInErrorState(this.msg);
  final String msg;
}

class SocialAccountNotExisting extends SignInState {}

class SignInSuccessState extends SignInState {
  SignInSuccessState(this.signedInData);

  final SignedInData signedInData;

}

class SignUpSuccessState extends SignInState {
  SignUpSuccessState(this.signedInData);

  final SignedInData signedInData;

}


