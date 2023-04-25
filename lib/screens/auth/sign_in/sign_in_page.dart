import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:app_chat_firebase/screens/auth/sign_in/bloc/sign_in_cubit.dart';
import 'package:base_component/widgets/app/loadding/app_top_layout.dart';
import 'package:flutter/material.dart';

part 'widget/password_field.dart';
part 'widget/email_field.dart';
part 'widget/user_name_field.dart';
part 'widget/confirm_password_field.dart';
part 'widget/sign_in_button.dart';

const _emailField = 'emailErrorMessages';
const _passwordField = 'passwordErrorMessages';
const _confirmPasswordField = 'confirmPasswordErrorMessages';
const _userNameField = '_userNameField';

enum SignType {
  login,
  register,
}

class SignInPage extends StatefulWidget {
  const SignInPage({super.key, this.type = SignType.login});

  final SignType type;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final FormGroup _formGroup;

  late final RxBool _isSignType;

  final _isLoading = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _isSignType = RxBool(widget.type == SignType.login);
    _formGroup = FormGroup({
      _emailField: FormControl<String>(touched: true, validators: [
        Validators.required,
        Validators.email,
      ]),
      _passwordField: FormControl<String>(validators: [Validators.required]),
    }, validators: [
      mustMatchPassword(controlName: _passwordField),
      mustMatchEmail(controlName: _emailField),
    ]);
    _additionalFields();
  }

  @override
  void dispose() {
    super.dispose();
    _isSignType.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SignInCubit(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<SignInCubit, SignInState>(listener: _signInListener),
        ],
        child: Scaffold(
          appBar: const DefaultAppBar(),
          extendBodyBehindAppBar: true,
          body: AppTopLayout.loadingOnTop(
            isLoading: _isLoading,
            child: Padding(
              padding: Dimens.edge_x_default,
              child: _body(context),
            ),
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
                Obx(
                  () => (_isSignType.value ? 'signIn' : 'register').tr().text.bold.textL.make(),
                ),
                Obx(() => _isSignType.value
                    ? Gaps.empty
                    : Column(
                        children: const [
                          Gaps.vGap30,
                          _UserNameField(),
                        ],
                      )),
                Gaps.vGap30,
                const _EmailField(),
                Gaps.vGap30,
                const _PasswordField(),
                Gaps.vGap30,
                Obx(() => _isSignType.value
                    ? Gaps.empty
                    : Column(
                        children: const [
                          _ConfirmPasswordField(),
                          Gaps.vGap30,
                        ],
                      )),
                const _SignInButton(),
                Gaps.vGap30,
                _signUpLabel(context),
              ],
            ),
          )),
    );
  }

  Widget _signUpLabel(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        "loginScreen.NotAccount".tr().text.size(Dimens.font_sp16).make(),
        CardCupertinoEffect(
          onPressed: () {
            _isSignType.value = !_isSignType.value;
            if (_formGroup.findControl(_confirmPasswordField) == null) {
              _additionalFields();
            }
          },
          child: Obx(() {
            return (!_isSignType.value ? "loginScreen.loginNow" : "loginScreen.register")
                .tr()
                .textAuto
                .size(Dimens.font_sp16)
                .underline
                .make();
          }),
        ),
      ],
    );
  }

  void _signInListener(BuildContext context, SignInState state) {
    // _isSignType.value = state is SigningInState;
  }

  void _additionalFields() {
    if (!_isSignType.value) {
      final confirmPassword = FormControl<String>(validators: [Validators.required]);
      final userName = FormControl<String>(validators: [
        Validators.required,
        Validators.minLength(4),
      ]);
      _formGroup.addAll({
        _confirmPasswordField: confirmPassword,
        _userNameField: userName,
      });
      _formGroup.setValidators([
        mustMatchPassword(
          controlName: _passwordField,
        ),
        mustMatchPasswordAndPasswordConfirmation(
          matchingControlName: _confirmPasswordField,
          controlName: _passwordField,
        ),
        mustMatchEmail(controlName: _emailField),
      ]);
    }
  }
}
