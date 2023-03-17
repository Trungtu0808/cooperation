import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:flutter/material.dart';

const _emailField = '_emailField';
const _passwordField = '_passwordField';
const _confirmPasswordField = '_confirmPasswordField';

enum SignType {
  login,
  register,
}

class SignPage extends StatefulWidget {
  const SignPage({super.key, this.type = SignType.register});

  final SignType type;

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final _formGroup = FormGroup({
    _emailField: FormControl<String>(),
    _passwordField: FormControl<String>(),
    _confirmPasswordField: FormControl<String>(),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: ReactiveForm(
        formGroup: _formGroup,
        child: Column(
          children: [
            ReactiveTextFormField(
              label: 'loginScreen.email'.tr(),
              formControlName: _emailField,
            ),

          ],
        ),
      )),
    );
  }
}
