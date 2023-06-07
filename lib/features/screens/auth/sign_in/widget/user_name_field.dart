part of '../sign_in_page.dart';

class _UserNameField extends StatelessWidget {
  const _UserNameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveTextFormField(
      formControlName: _userNameField,
      required: false,
      label: 'loginScreen.fullName'.tr(),
      hintText: 'loginScreen.fullNameInputHint'.tr(),
      textInputAction: TextInputAction.next,
      maxLines: 1,
    );
  }
}
