part of '../sign_in_page.dart';

class _SignInButton extends StatelessWidget {
  const _SignInButton({
    Key? key,
    required this.signInType,
  }) : super(key: key);

  final bool signInType;
  @override
  Widget build(BuildContext context) {
    final form = ReactiveForm.of(context);
    return ActionButton(
      text: 'loginScreen.login'.tr(),
      onTap: form?.valid == true ? () => _onSigIn(context: context, form: form as FormGroup) : null,
    );
  }

  void _onSigIn({
    required BuildContext context,
    required FormGroup form,
  }) {
    final password = form.control(_passwordField).value as String;
    final email = form.control(_emailField).value as String;
    if (signInType) {
      context
          .read<SignInCubit>()
          .signInWithEmail(password: password, email: email);

    } else {
      //final passwordConfirm = form.control(_confirmPasswordField).value as String;
      final userName = form.control(_userNameField).value as String;
      context
          .read<SignInCubit>()
          .signUpWithEmail(userName: userName, password: password, email: email);
    }
  }
}
