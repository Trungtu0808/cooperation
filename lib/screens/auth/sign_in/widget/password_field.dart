part of '../sign_in_page.dart';

class _PasswordField extends StatelessWidget {
  const _PasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactivePasswordTextFormField(
      formControlName: _passwordField,
      label: 'loginScreen.password'.tr(),
      hintText: 'loginScreen.passwordInputHint'.tr(),
      contentPadding: ReactivePasswordTextFormField.contentPaddingMedium,
    );
  }
}