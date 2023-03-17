import 'package:flutter/material.dart';

extension AppThemeContextExtend on BuildContext {
  AppThemeExtension get themeColor =>
      Theme.of(this).extension<AppThemeExtension>() ?? AppThemeExtension.light;
}

@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  const AppThemeExtension({
    required this.n4,
    required this.n5,
    required this.n6,
    required this.n7,
    required this.n7V1,
    required this.n8,
    required this.n9,
    required this.n9V1,
    required this.primaryDark,
    required this.primaryLightest,
    required this.n3,
    required this.gray5,
    required this.gray6,
    required this.gray,
    required this.darkerGray,
    required this.link,
    required this.divider,
    required this.success,
    required this.error,
    required this.warning,
    required this.info,
    required this.backgroundSecondary,
    required this.unselectedWidget,
    required this.background3,
    required this.background4,
    required this.background5,
    required this.background6,
    required this.background7,
    required this.n1,
    required this.n2,
    required this.focused,
    required this.bgLightOrange,
    required this.pending,
    required this.approved,
    required this.rejected,
    required this.backgroundGrayBlue,
    required this.bgApproved,
    required this.bgRejected,
    required this.bgHideEnableTextField,
  });

  static const AppThemeExtension dark = AppThemeExtension(
    n4: Color(0xFF069BA5),
    n5: Color(0xFF858C94),
    n6: Color(0xFFA5ABB3),
    n7: Color(0xFF23A757),
    n7V1: Color(0xFFDADEE3),
    n8: Color(0xFFEBEEF2),
    n9: Color(0xFFD3F1F3),
    n9V1: Color(0xFFF8F8F8),
    primaryDark: Color(0xFF0399A3),
    primaryLightest: Color(0xFFE5FFFF),
    n3: Color(0xFF545D69),
    gray5: Color(0xFF8C8C8C),
    gray6: Color(0xFFF2F2F2),
    gray: Color(0xFF444444),
    darkerGray: Color(0xFFE1E1E1),
    link: Color(0xFF5587EA),
    divider: Color(0xFFDADEE3),
    success: Color(0xFF00B865),
    error: Color(0xFFD50000),
    warning: Color(0xFFFFC400),
    info: Color(0xFF5587EA),
    backgroundSecondary: Color(0xFFFFFFFF),
    unselectedWidget: Color(0xFF6D7580),
    background3: Color(0xffFAFAFA),
    background4: Color.fromARGB(203, 24, 24, 24),
    background5: Color(0xffF8F8F8),
    background6: Color(0xffEEF2FA),
    background7: Color(0xffF2EDFF),
    n1: Color(0xff394452),
    n2: Color(0xFFCECECE),
    focused: Color(0xFFDA1414),
    bgLightOrange: Color(0xFFFDEDC8),
    pending: Color(0xFFFFB400),
    approved: Color(0xFF23A757),
    rejected: Color(0xFFDA1414),
    backgroundGrayBlue: Color(0xffEAEEF2),
    bgApproved: Color(0xFFDBFFD8),
    bgRejected: Color(0xFFFEEFEF),
    bgHideEnableTextField: Color(0xFFD3F1F3),
  );

  static const AppThemeExtension light = AppThemeExtension(
    n4: Color(0xFF069BA5),
    n5: Color(0xFF858C94),
    n6: Color(0xFFA5ABB3),
    n7: Color(0xFF23A757),
    n7V1: Color(0xFFDADEE3),
    n8: Color(0xFFEBEEF2),
    n9: Color(0xFFD3F1F3),
    n9V1: Color(0xFFF8F8F8),
    primaryDark: Color(0xFF0399A3),
    primaryLightest: Color(0xFFE5FFFF),
    n3: Color(0xFF545D69),
    gray5: Color(0xFF8C8C8C),
    gray6: Color(0xFFF2F2F2),
    gray: Color(0xFF444444),
    darkerGray: Color(0xFFE1E1E1),
    link: Color(0xFF5587EA),
    divider: Color(0xFFDADEE3),
    success: Color(0xFF00B865),
    error: Color(0xFFD50000),
    warning: Color(0xFFFFC400),
    info: Color(0xFF5587EA),
    backgroundSecondary: Color(0xFFFFFFFF),
    unselectedWidget: Color(0xFF6D7580),
    background3: Color(0xffFAFAFA),
    background4: Color.fromARGB(203, 24, 24, 24),
    background5: Color(0xffF8F8F8),
    background6: Color(0xffEEF2FA),
    background7: Color(0xffF2EDFF),
    n1: Color(0xff394452),
    n2: Color(0xFFCECECE),
    focused: Color(0xFFDA1414),
    bgLightOrange: Color(0xFFFDEDC8),
    pending: Color(0xFFFFB400),
    approved: Color(0xFF23A757),
    rejected: Color(0xFFDA1414),
    backgroundGrayBlue: Color(0xffEAEEF2),
    bgApproved: Color(0xFFDBFFD8),
    bgRejected: Color(0xFFFEEFEF),
    bgHideEnableTextField: Color(0xFFD3F1F3),
  );

  final Color n3;
  final Color n5;
  final Color n6;
  final Color n7;
  final Color n7V1;
  final Color n8;
  final Color n9;
  final Color n9V1;
  final Color primaryDark;
  final Color primaryLightest;
  final Color gray5;
  final Color gray6;
  final Color gray;
  final Color darkerGray;
  final Color link;
  final Color divider;
  final Color success;
  final Color error;
  final Color warning;
  final Color info;
  final Color backgroundSecondary;
  final Color unselectedWidget;
  final Color background3;
  final Color background4;
  final Color background5;
  final Color background6;
  final Color background7;
  final Color n1;
  final Color n2;
  final Color focused;
  final Color bgLightOrange;
  final Color pending;
  final Color approved;
  final Color n4;
  final Color rejected;
  final Color backgroundGrayBlue;
  final Color bgApproved;
  final Color bgRejected;
  final Color bgHideEnableTextField;
  @override
  AppThemeExtension copyWith({Color? brandColor, Color? danger}) {
    return AppThemeExtension(
      n4: n4,
      n5: n5,
      n6: n6,
      n7: n7,
      n7V1: n7V1,
      n8: n8,
      n9: n9,
      n9V1: n9V1,
      primaryDark: primaryDark,
      primaryLightest: primaryLightest,
      n3: n3,
      gray5: gray5,
      gray6: gray6,
      gray: gray,
      darkerGray: darkerGray,
      link: link,
      divider: divider,
      success: success,
      error: error,
      warning: warning,
      info: info,
      backgroundSecondary: backgroundSecondary,
      unselectedWidget: unselectedWidget,
      background3: background3,
      background4: background4,
      background5: background5,
      background6: background6,
      background7: background7,
      n1: n1,
      n2: n2,
      focused: focused,
      bgLightOrange: bgLightOrange,
      pending: pending,
      approved: approved,
      rejected: rejected,
      backgroundGrayBlue: backgroundGrayBlue,
      bgApproved: bgApproved,
      bgRejected: bgRejected,
      bgHideEnableTextField: bgHideEnableTextField,
    );
  }

  @override
  AppThemeExtension lerp(ThemeExtension<AppThemeExtension>? other, double t) {
    if (other is! AppThemeExtension) {
      return this;
    }
    return AppThemeExtension(
      n4: Color.lerp(n4, other.n4, t) ?? n4,
      n5: Color.lerp(n5, other.n5, t) ?? n5,
      n6: Color.lerp(n6, other.n6, t) ?? n6,
      n7: Color.lerp(n7, other.n7, t) ?? n7,
      n7V1: Color.lerp(n7V1, other.n7V1, t) ?? n7V1,
      n8: Color.lerp(n8, other.n8, t) ?? n8,
      n9: Color.lerp(n9, other.n9, t) ?? n9,
      n9V1: Color.lerp(n9V1, other.n9V1, t) ?? n9V1,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t) ?? primaryDark,
      primaryLightest: Color.lerp(primaryLightest, other.primaryLightest, t) ?? primaryLightest,
      n3: Color.lerp(n3, other.n3, t) ?? n3,
      gray5: Color.lerp(gray5, other.gray5, t) ?? gray5,
      gray6: Color.lerp(gray6, other.gray6, t) ?? gray6,
      gray: Color.lerp(gray, other.gray, t) ?? gray,
      darkerGray: Color.lerp(darkerGray, other.darkerGray, t) ?? darkerGray,
      link: Color.lerp(link, other.link, t) ?? link,
      divider: Color.lerp(divider, other.divider, t) ?? divider,
      success: Color.lerp(success, other.success, t) ?? success,
      error: Color.lerp(error, other.error, t) ?? error,
      warning: Color.lerp(warning, other.warning, t) ?? warning,
      info: Color.lerp(info, other.info, t) ?? info,
      backgroundSecondary:
          Color.lerp(backgroundSecondary, backgroundSecondary, t) ?? backgroundSecondary,
      unselectedWidget: Color.lerp(unselectedWidget, other.unselectedWidget, t) ?? unselectedWidget,
      background3: Color.lerp(background3, other.background3, t) ?? background3,
      background4: Color.lerp(background4, other.background4, t) ?? background4,
      background5: Color.lerp(background5, other.background5, t) ?? background5,
      background6: Color.lerp(background6, other.background6, t) ?? background6,
      background7: Color.lerp(background7, other.background7, t) ?? background7,
      n1: Color.lerp(n1, other.n1, t) ?? n1,
      n2: Color.lerp(n2, other.n2, t) ?? n2,
      focused: Color.lerp(focused, other.focused, t) ?? focused,
      bgLightOrange: Color.lerp(bgLightOrange, other.bgLightOrange, t) ?? bgLightOrange,
      pending: Color.lerp(pending, other.pending, t) ?? pending,
      approved: Color.lerp(approved, other.approved, t) ?? approved,
      rejected: Color.lerp(rejected, other.rejected, t) ?? rejected,
      backgroundGrayBlue:
          Color.lerp(backgroundGrayBlue, other.backgroundGrayBlue, t) ?? backgroundGrayBlue,
      bgApproved: Color.lerp(bgApproved, other.bgApproved, t) ?? bgApproved,
      bgRejected: Color.lerp(bgRejected, other.bgRejected, t) ?? bgRejected,
      bgHideEnableTextField: Color.lerp(bgHideEnableTextField, other.bgHideEnableTextField, t) ?? bgHideEnableTextField,
    );
  }

  factory AppThemeExtension.of(BuildContext context) {
    return Theme.of(context).extension as AppThemeExtension;
  }

  factory AppThemeExtension.form(bool isDark) {
    return isDark ? AppThemeExtension.dark : AppThemeExtension.light;
  }

  static ColorScheme colorSchemaFrom({required bool isDark}) {
    return isDark ? _colorSchemeDark : _colorScheme;
  }
}

const ColorScheme _colorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF08B3BF),
  onPrimary: Color(0xFFffffff),
  primaryContainer: Color(0xFFb7eaff),
  onPrimaryContainer: Color(0xFF001f2a),
  secondary: Color(0xFF4c616b),
  onSecondary: Color(0xFFffffff),
  secondaryContainer: Color(0xFFcfe6f1),
  onSecondaryContainer: Color(0xFF071e26),
  tertiary: Color(0xFF5b5b7e),
  onTertiary: Color(0xFFffffff),
  tertiaryContainer: Color(0xFFe1dfff),
  onTertiaryContainer: Color(0xFF181837),
  error: Color(0xFFCB2222),
  onError: Color(0xFFffffff),
  errorContainer: Color(0xFFffdad4),
  onErrorContainer: Color(0xFF410001),
  background: Color(0xFFFFFFFF),
  onBackground: Color(0xFF191c1e),
  surface: Color(0xffffffff),
  onSurface: Color(0xFF191c1e),
  outline: Color(0xFF70787d),
  surfaceVariant: Color(0xFFdce4e8),
  onSurfaceVariant: Color(0xFF40484c),
);

const ColorScheme _colorSchemeDark = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF08B3BF),
  onPrimary: Color(0xFFffffff),
  primaryContainer: Color(0xFFb7eaff),
  onPrimaryContainer: Color(0xFF001f2a),
  secondary: Color(0xFF4c616b),
  onSecondary: Color(0xFFffffff),
  secondaryContainer: Color(0xFFcfe6f1),
  onSecondaryContainer: Color(0xFF071e26),
  tertiary: Color(0xFF5b5b7e),
  onTertiary: Color(0xFFffffff),
  tertiaryContainer: Color(0xFFe1dfff),
  onTertiaryContainer: Color(0xFF181837),
  error: Color(0xFFCB2222),
  onError: Color(0xFFffffff),
  errorContainer: Color(0xFFffdad4),
  onErrorContainer: Color(0xFF410001),
  background: Color(0xFFFFFFFF),
  onBackground: Color(0xFF191c1e),
  surface: Color(0xffffffff),
  onSurface: Color(0xFF191c1e),
  outline: Color(0xFF70787d),
  surfaceVariant: Color(0xFFdce4e8),
  onSurfaceVariant: Color(0xFF40484c),
);
