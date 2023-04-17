part of 'sign_in_cubit.dart';
abstract class SignInState{}

class SignInInitState extends SignInState{}

class SigningInState extends SignInState{}

class SignInErrorState extends SignInState{
  SignInErrorState(this.msg);
  final String msg;

}