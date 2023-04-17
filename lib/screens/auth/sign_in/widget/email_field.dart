part of '../sign_in_page.dart';

class _EmailField extends StatelessWidget {
  const _EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveTextFormField(
      formControlName: _userNameField,
      required: false,
      label: 'loginScreen.email'.tr(),
      hintText: 'loginScreen.emailInputHint'.tr(),
      textInputAction: TextInputAction.next,
      maxLines: 1,
    );
  }
}