// ignore: unnecessary_this
import 'package:base_component/import_all.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

extension ThemeExtend on ThemeData {
  Color defaultTextColor() {
    return primaryTextTheme.bodyMedium!.color!;
  }

  Color onPrimary() {
    return colorScheme.onPrimary;
  }

  Color onAccent() {
    return primaryTextTheme.bodyMedium!.color!;
  }

  Color lightGrey() {
    return hintColor.withOpacity(0.6);
  }

  Color darkText() {
    return Get.isDarkMode ? Colors.white : Colors.black;
  }
}

extension StringVelocityExtend on String {
  /// Get Text Widget for the String
  VxTextBuilder get text => VxTextBuilder(this).isIntrinsic;

  VxTextBuilder get textAuto => VxTextBuilder(this);
}

extension VxTextBuilderExtend on VxTextBuilder {
  VxTextBuilder get textXS => size(Dimens.text_XS);

  VxTextBuilder get textMidXS => size(Dimens.text_mid_XS);

  VxTextBuilder get textS => size(Dimens.text_S);
  
  VxTextBuilder get textMidS => size(Dimens.text_mid_S);

  VxTextBuilder get textBase => size(Dimens.text);

  VxTextBuilder get textL => size(Dimens.text_L);

  VxTextBuilder get textLMid => size(Dimens.text_L_mid);

  VxTextBuilder get textXL => size(Dimens.text_XL);

  VxTextBuilder colorPrimary(BuildContext context) {
    // ignore: invalid_use_of_protected_member
   velocityColor = Theme.of(context).primaryColor;
    return this;
  }

  VxTextBuilder colorError(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    velocityColor = Theme.of(context).colorScheme.error;
    return this;
  }

  VxTextBuilder colorTransparent(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    velocityColor = Colors.transparent;
    return this;
  }

  VxTextBuilder colorOnPrimary(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    velocityColor = Theme.of(context).onPrimary();
    return this;
  }

  VxTextBuilder colorOnAccent(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    velocityColor = Theme.of(context).onAccent();
    return this;
  }

  VxTextBuilder colorLink(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    velocityColor = context.themeColor.link;
    return this;
  }

  VxTextBuilder colorHint(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    velocityColor = Theme.of(context).hintColor;
    return this;
  }

  VxTextBuilder colorN1(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    velocityColor = context.themeColor.n1;
    return this;
  }

  VxTextBuilder colorN3(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    velocityColor = context.themeColor.n3;
    return this;
  }

  VxTextBuilder colorN4(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    velocityColor = context.themeColor.unselectedWidget;
    return this;
  }

  VxTextBuilder colorN5(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    velocityColor = context.themeColor.unselectedWidget;
    return this;
  }

  VxTextBuilder colorTitle(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    velocityColor = context.themeColorText.subTitleSecondary;
    return this;
  }

  VxTextBuilder colorN6(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    velocityColor = context.themeColor.n6;
    return this;
  }

  VxTextBuilder colorGray(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    velocityColor = context.themeColor.gray;
    return this;
  }

  VxTextBuilder colorGray5(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    velocityColor = context.themeColor.gray5;
    return this;
  }

  VxTextBuilder price() {
    return this;
  }
}

extension WidgetExtend on Widget {

  Padding pRight8({Key? key}) => Padding(
    key: key,
    padding: const EdgeInsets.only(right: Dimens.gap_dp8),
    child: this,
  );
}