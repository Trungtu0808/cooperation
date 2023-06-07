import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:app_chat_firebase/widgets/cards/card_gray_border.dart';
import 'package:flutter/material.dart';

class SocialSignMethod extends StatelessWidget {
  const SocialSignMethod({
    Key? key,
    this.onGoogleSignIn,
    this.onFacebookSignIn,
    this.onAppleSignIn,
  }) : super(key: key);

  final VoidCallback? onGoogleSignIn;
  final VoidCallback? onFacebookSignIn;
  final VoidCallback? onAppleSignIn;

  static const _supportedSocialSignIn = [
    SupportedSocialSignIn.apple,
    SupportedSocialSignIn.google,
    SupportedSocialSignIn.facebook,
  ];
  @override
  Widget build(BuildContext context) {
    final items = _supportedSocialSignIn.mapAsList((item) => CardGrayBorder(
      onPressed: _obtainOnTab(item),
          child: SizedBox(
            height: 56.0,
            width: 56.0,
            child: Center(
              child: SizedBox(
                width: 25.0,
                height: 25.0,
                child: item.icon,
              ),
            ),
          ),
        ));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: items.withDivider(Gaps.hGap12),
    );
  }

  VoidCallback? _obtainOnTab(SupportedSocialSignIn signIn){
    switch(signIn){
      case SupportedSocialSignIn.apple:
        return onAppleSignIn;
      case SupportedSocialSignIn.facebook:
        return onFacebookSignIn;
      case SupportedSocialSignIn.google:
        return onGoogleSignIn;
    }
  }
}

enum SupportedSocialSignIn {
  google,
  apple,
  facebook,
}

extension SupportedSocialSigInExtention on SupportedSocialSignIn {
  Widget get icon {
    switch (this) {
      case SupportedSocialSignIn.apple:
        return Assets.icons.png.appleLogo.image();
      case SupportedSocialSignIn.google:
        return Assets.icons.png.ggLogo.image();
      case SupportedSocialSignIn.facebook:
        return Assets.icons.png.fbLogo.image();
    }
  }
}
