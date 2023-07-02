import 'package:app_chat_firebase/features/blocs/auth/auth_bloc.dart';
import 'package:app_chat_firebase/features/screens/auth/social_auth/social_auth_cubit.dart';
import 'package:app_chat_firebase/features/screens/auth/social_auth/social_auth_state.dart';
import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:app_chat_firebase/features/screens/auth/sign_in/bloc/sign_in_cubit.dart';
import 'package:app_chat_firebase/widgets/popups.dart';
import 'package:app_chat_firebase/widgets/social_sign_methods.dart';
import 'package:app_model/enums.dart';
import 'package:app_model/features/auth/resp/signed_in_data.dart';
import 'package:flutter/material.dart';

part 'widget/password_field.dart';
part 'widget/email_field.dart';
part 'widget/user_name_field.dart';
part 'widget/confirm_password_field.dart';
part 'widget/sign_in_button.dart';
part 'widget/social_sign_in.dart';

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
        BlocProvider(
          create: (_) => SocialAuthCubit(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<SignInCubit, SignInState>(listener: _signInListener),
          BlocListener<SocialAuthCubit, SocialAuthState>(listener: _socialAuthSignInListener),
          BlocListener<AuthBloc, AuthState>(listener: _authListener),
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
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Gaps.vGap30,
                Obx(
                  () => (_isSignType.value ? 'signIn' : 'register').tr().text.bold.textL.make(),
                ),
                Obx(() => _isSignType.value
                    ? Gaps.empty
                    : const Column(
                        children: [
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
                    : const Column(
                        children: [
                          _ConfirmPasswordField(),
                          Gaps.vGap30,
                        ],
                      )),
                Obx(() {
                    return _SignInButton(signInType: _isSignType.value,);
                  }
                ),
                Gaps.vGap30,
                _signUpLabel(context),
                Gaps.vGap30,
                const _SocialSignIn()
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
    _isLoading.value = state is SigningInState;
    if (state is SignUpSuccessState){
      _onSignUpSuccessful(context, state.signedInData);
    } else if (state is SignInSuccessState){
      _onSignInSuccessful(context, state.signedInData);
    }
    else if (state is SignInErrorState){
      //DialogUtils.showAlertDialog(context);
      context.showAlertDialog(context, title: state.msg);
    }
  }

  void _socialAuthSignInListener(BuildContext context, SocialAuthState state){
    _isLoading.value = state is SocialSigningInState;
    if (state is SocialSignInCanceled){
      context.showErrorPopup(msg: state.msg ?? '');
    } else if (state is SocialSignInSuccessful){
      _onSocialSignInSuccessful(context, state.data);
    } else if (state is SocialAuthError){
      context.showErrorPopup(msg: state.msg);
    }
  }

  void _authListener(BuildContext context, AuthState state){
    if (state is AuthenticatedState){
      if ([AuthenticatedType.signUp, AuthenticatedType.signIn,].contains(state.authenticatedType)){
        context.router.pushAndPopUntil(const HomeRoute(), predicate: (route) => false);
      }
    }
  }


  void _onSignUpSuccessful(BuildContext context, SignedInData signedInData){
    context.read<AuthBloc>().add(AuthSignUpSuccessEvent(signedInData: signedInData));
  }

  void _onSignInSuccessful(BuildContext context, SignedInData signedInData){
    context.read<AuthBloc>().add(AuthSignInSuccessEvent(signedInData: signedInData));
  }


  void _onSocialSignInSuccessful(BuildContext context, SignedInData signedInData){
    context.read<AuthBloc>().add(AuthSignInSuccessEvent(signedInData: signedInData));
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
