import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:app_chat_firebase/screens/auth/sign_in/bloc/sign_in_cubit.dart';
import 'package:app_chat_firebase/widgets/app_bar/default_appbar.dart';
import 'package:flutter/material.dart';

part 'widget/password_field.dart';
part 'widget/email_field.dart';
part 'widget/user_name_field.dart';
part 'widget/sign_in_button.dart';

const _emailField = '_emailField';
const _passwordField = '_passwordField';
const _confirmPasswordField = '_confirmPasswordField';
const _userNameField = '_userNameField';

enum SignType {
  login,
  register,
}

class SignInPage extends StatefulWidget {
  const SignInPage({super.key, this.type = SignType.register});

  final SignType type;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formGroup = FormGroup({
    _emailField: FormControl<String>(),
    _passwordField: FormControl<String>(),
    _confirmPasswordField: FormControl<String>(),
    _userNameField: FormControl<String>(),
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SignInCubit(),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: const DefaultAppBar(),
          extendBodyBehindAppBar: true,
          body: Padding(
            padding: Dimens.edge_x_default,
            child: _body(context),
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SizedBox.expand(
      child: SingleChildScrollView(
          padding: EdgeInsets.only(top: context.mediaQueryPadding.top + DefaultAppBar.height),
          physics: const AlwaysScrollableScrollPhysics(),
          child: ReactiveForm(
            formGroup: _formGroup,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Gaps.vGap30,
                'signIn'.tr().text.bold.textL.make(),
                Gaps.vGap30,
                const _UserNameField(),
                Gaps.vGap30,
                const _EmailField(),
                Gaps.vGap30,
                const _PasswordField(),
                Gaps.vGap30,
                const _SignInButton(),
              ],
            ),
          )),
    );
  }
}
