part of '../sign_in_page.dart';

class _ConfirmPasswordField extends StatelessWidget {
  const _ConfirmPasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactivePasswordTextFormField(
      formControlName: _confirmPasswordField,
      label: 'loginScreen.passwordConfirm'.tr(),
      hintText: 'loginScreen.passwordConfirmInputHint'.tr(),
      validationMessages: {
        ValidationMessage.required : (error) => _confirmPasswordField.tr(),
      },
      isShowError: true,
      showErrors: (control) => control.invalid && control.touched && control.dirty,
      contentPadding: ReactivePasswordTextFormField.contentPaddingMedium,
      maxLines: 1,
    );
  }
}
