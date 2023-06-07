import 'package:app_model/features/auth/resp/signed_in_data.dart';

class SocialAuthState {}

class Initializing  extends SocialAuthState{}

class SocialSigningIn extends SocialAuthState{}

class SocialSignInCanceled extends SocialAuthState{}

class SocialSignInSuccessful extends SocialAuthState{
  SocialSignInSuccessful(this.data);

  final SignedInData data;

}

class SocialAuthError  extends SocialAuthState{
  SocialAuthError(this.msg);

  final String msg;
}