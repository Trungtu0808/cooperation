part of '../sign_in_page.dart';

class _SignInButton extends StatelessWidget {
  const _SignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final form = ReactiveForm.of(context) as FormGroup;

    return ActionButton(
      text: 'loginScreen.login'.tr(),
      onTap: form.valid == true ? () => _onSigIn(context: context, form: form) : null,
    );
  }

  void _onSigIn({
    required BuildContext context,
    required FormGroup form,
  }) {
    final userName = form.control(_userNameField).value as String;
    final password = form.control(_passwordField).value as String;
    //final passwordConfirm = form.control(_confirmPasswordField).value as String;
    //context.read<SignInCubit>().signInWithUsername(username: userName, password: password);
  }
}
