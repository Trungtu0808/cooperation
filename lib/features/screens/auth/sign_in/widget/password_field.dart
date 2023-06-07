part of '../sign_in_page.dart';

class _PasswordField extends StatelessWidget {
  const _PasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactivePasswordTextFormField(
      formControlName: _passwordField,
      showErrors: (control) {
        return control.invalid && control.touched && control.dirty;
      },
      isShowError: true,
      label: 'loginScreen.password'.tr(),
      hintText: 'loginScreen.passwordInputHint'.tr(),
      textInputAction: TextInputAction.next,
      contentPadding: ReactivePasswordTextFormField.contentPaddingMedium,
      maxLines: 1,
    );
  }
}
