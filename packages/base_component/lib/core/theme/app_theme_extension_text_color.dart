
import 'package:flutter/material.dart';

extension AppThemeTextColorContextExtend on BuildContext {
  AppThemeTextColorExtension get themeColorText =>
      Theme.of(this).extension<AppThemeTextColorExtension>() ??
      AppThemeTextColorExtension.light;
}

@immutable
class AppThemeTextColorExtension extends ThemeExtension<AppThemeTextColorExtension> {

  const AppThemeTextColorExtension({
    required this.text,
    required this.textLink,
    required this.textGray,
    required this.textDark,
    required this.textHint,
    required this.textHintLight,
    required this.textHeading,
    required this.textDisable,
    required this.content,
    required this.subTitle,
    required this.subTitleSecondary,
    required this.subTitleThird,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.text5,
    required this.text6,
    required this.onBackground,
    required this.text7,
    required this.text8,
    required this.text9,
    required this.text10,
    required this.text11,
    required this.text12,
    required this.focused,
    required this.negative,
    required this.reverse,
  });

  static const AppThemeTextColorExtension dark = AppThemeTextColorExtension(
    text: Color(0xFF242424),
    textLink: Color(0xFF5587EA),
    textGray: Color(0xFF444444),
    textDark: Color(0xFF444444),
    textHint: Color(0xFF9B9B9B),
    textHintLight: Color(0xFFE4E4E4),
    textHeading: Color(0xFF081F32),
    textDisable: Color(0xFFD4E2FA),
    content: Color(0xFF000817),
    subTitle: Color(0xFF545D69),
    subTitleSecondary: Color(0xFF6D7580),
    subTitleThird: Color(0xFF858C94),
    text2: Color(0xFFA5ABB3),
    text3: Color(0xFF6E798C),
    text4: Color(0xFF394452),
    text5: Color(0xff09101D),
    text6: Color(0xFF151920),
    text7: Color(0xFF3A4348),
    text8: Color(0xFF2C3A4B),
    text9: Color(0xff000000),
    text10: Color(0xffED8000),
    text11: Color(0xff2162DF),
    text12: Color(0xff6B48D1),
    onBackground: Colors.black,
    focused: Color(0xFFDA1414),
    negative: Color(0xFFE22222),
    reverse: Color(0xFFFFFFFF),
  );

  static const AppThemeTextColorExtension light = AppThemeTextColorExtension(
    text: Color(0xFF242424),
    textLink: Color(0xFF5587EA),
    textGray: Color(0xFF444444),
    textDark: Color(0xFF444444),
    textHint: Color(0xFF9B9B9B),
    textHintLight: Color(0xFFE4E4E4),
    textHeading: Color(0xFF081F32),
    textDisable: Color(0xFFD4E2FA),
    content: Color(0xFF000817),
    subTitle: Color(0xFF545D69),
    subTitleSecondary: Color(0xFF6D7580),
    subTitleThird: Color(0xFF858C94),
    text2: Color(0xFFA5ABB3),
    text3: Color(0xFF6E798C),
    text4: Color(0xFF394452),
    text5: Color(0xff09101D),
    text6: Color(0xFF151920),
    text7: Color(0xFF3A4348),
    text8: Color(0xFF2C3A4B),
    text9: Color(0xff000000),
    text10: Color(0xffED8000),
    text11: Color(0xff2162DF),
    text12: Color(0xff6B48D1),
    onBackground: Colors.black,
    focused: Color(0xFFDA1414),
    negative: Color(0xFFE22222),
    reverse: Color(0xFFFFFFFF),
  );

  final Color text;
  final Color textLink;
  final Color textGray;
  final Color textDark;
  final Color textHint;
  final Color textHintLight;
  final Color textHeading;
  final Color textDisable;
  final Color content;
  final Color subTitle;
  final Color subTitleSecondary;
  final Color subTitleThird;
  final Color onBackground;
  final Color text2;
  final Color text3;
  final Color text4;
  final Color text5;
  final Color text6;
  final Color text7;
  final Color text8;
  final Color text9;
  final Color text10;
  final Color text11;
  final Color text12;
  final Color focused;
  final Color negative;
  final Color reverse;

  @override
  AppThemeTextColorExtension copyWith({Color? brandColor, Color? danger}) {
    return AppThemeTextColorExtension(
      text: brandColor ?? text,
      textLink: brandColor ?? textLink,
      textGray: brandColor ?? textGray,
      textDark: brandColor ?? textDark,
      textHint: brandColor ?? textHint,
      textHintLight: brandColor ?? textHintLight,
      textHeading: brandColor ?? textHeading,
      textDisable: brandColor ?? textDisable,
      content: content,
      subTitle: subTitle,
      subTitleSecondary: subTitleSecondary,
      subTitleThird: subTitleThird,
      text2: text2,
      text3: text3,
      text4: text4,
      text5: text5,
      text6: text6,
      text7: text7,
      text8: text8,
      text9: text9,
      text10: text10,
      text11: text11,
      text12: text12,
      onBackground: onBackground,
      focused: focused,
      negative: negative,
      reverse: reverse,
    );
  }

  @override
  AppThemeTextColorExtension lerp(ThemeExtension<AppThemeTextColorExtension>? other, double t) {
    if (other is! AppThemeTextColorExtension) {
      return this;
    }
    return AppThemeTextColorExtension(
      text: Color.lerp(text, other.text, t) ?? text,
      textLink: Color.lerp(textLink, other.textLink, t) ?? textLink,
      textGray: Color.lerp(textGray, other.textGray, t) ?? textGray,
      textDark: Color.lerp(textDark, other.textDark, t) ?? textDark,
      textHint: Color.lerp(textHint, other.textHint, t) ?? textHint,
      textHintLight: Color.lerp(textHintLight, other.textHintLight, t) ?? textHintLight,
      textHeading: Color.lerp(textHeading, other.textHeading, t) ?? textHeading,
      textDisable: Color.lerp(textDisable, other.textDisable, t) ?? textDisable,
      content: Color.lerp(content, other.content, t) ?? content,
      subTitle: Color.lerp(subTitle, other.subTitle, t) ?? subTitle,
      subTitleSecondary: Color.lerp(subTitleSecondary, other.subTitleSecondary, t) ?? subTitleSecondary,
      subTitleThird: Color.lerp(subTitleThird, other.subTitleThird, t) ?? subTitleThird,
      text2: Color.lerp(text2, other.text2, t) ?? text2,
      text3: Color.lerp(text3, other.text3, t) ?? text3,
      text4: Color.lerp(text4, other.text4, t) ?? text4,
      text5: Color.lerp(text5, other.text5, t) ?? text5,
      text6: Color.lerp(text6, other.text6, t) ?? text6,
      text7: Color.lerp(text7, other.text7, t) ?? text7,
      text8: Color.lerp(text8, other.text8, t) ?? text8,
      text9: Color.lerp(text9, other.text9, t) ?? text9,
      text10: Color.lerp(text10, other.text10, t) ?? text10,
      text11: Color.lerp(text11, other.text11, t) ?? text11,
      text12: Color.lerp(text12, other.text12, t) ?? text12,
      onBackground: Color.lerp(onBackground, other.onBackground, t) ?? onBackground,
      focused: Color.lerp(focused, other.focused, t) ?? focused,
      negative: Color.lerp(negative, other.negative, t) ?? negative,
      reverse: Color.lerp(reverse, other.reverse, t) ?? reverse,
    );
  }

  factory AppThemeTextColorExtension.of(BuildContext context) {
    return Theme.of(context).extension as AppThemeTextColorExtension;
  }

  factory AppThemeTextColorExtension.form(bool isDark) {
    return isDark ? AppThemeTextColorExtension.dark : AppThemeTextColorExtension.light;
  }
}
