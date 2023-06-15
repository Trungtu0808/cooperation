part of'../sign_in_page.dart';

class _SocialSignIn extends StatelessWidget {
  const _SocialSignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SocialSignMethod(
      onAppleSignIn: (){
        context.read<SocialAuthCubit>().signInWithSocialAccount(AccountTypes.APPLE_ACC_TYPE);
      },
      onFacebookSignIn: (){
        context.read<SocialAuthCubit>().signInWithSocialAccount(AccountTypes.FACEBOOK_ACC_TYPE);

      },
      onGoogleSignIn: (){
        context.read<SocialAuthCubit>().signInWithSocialAccount(AccountTypes.GOOGLE_ACC_TYPE);
      },
    );
  }
}
