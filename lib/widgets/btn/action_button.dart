import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton(
      {Key? key,
      required this.text,
      this.onTap,
      this.type = ActionButtonType.primary,
      this.fontWeight = FontWeight.w400,
      this.icon,
      this.padding = 0,
      this.width,
      this.height,
      this.radius,
      this.isTextAndIcon = false})
      : super(key: key);

  static const _itemHeight = 48.0;

  final VoidCallback? onTap;
  final String text;
  final ActionButtonType type;
  final FontWeight fontWeight;
  final Widget? icon;
  final double padding;
  final double? width;
  final double? height;
  final double? radius;
  final bool isTextAndIcon;

  @override
  Widget build(BuildContext context) {
    return CardCupertinoEffect(
      onPressed: onTap,
      child: Container(
        height: height ?? _itemHeight,
        width: width,
        padding: EdgeInsets.all(padding),
        decoration: _obtainDecoration(context),
        child: Center(
          child: isTextAndIcon
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Offstage(
                      offstage: icon == null,
                      child: icon,
                    ).pRight8(),
                    text.textAuto
                        .fontWeight(fontWeight)
                        .size(Dimens.font_sp17)
                        .semiBold
                        .color(_obtainTextColor(context))
                        .make()
                        .centered()
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Offstage(
                      offstage: icon == null,
                      child: icon,
                    ),
                    icon != null
                        ? text.textAuto
                            .fontWeight(fontWeight)
                            .size(Dimens.font_sp17)
                            .semiBold
                            .color(_obtainTextColor(context))
                            .make()
                            .centered()
                        : Expanded(
                            child: text.textAuto
                                .fontWeight(fontWeight)
                                .size(Dimens.font_sp17)
                                .semiBold
                                .color(_obtainTextColor(context))
                                .make()
                                .centered())
                  ],
                ),
        ),
      ),
    );
  }

  BoxDecoration? _obtainDecoration(BuildContext context) {
    final borderRadius = BorderRadius.circular(radius ?? _itemHeight / 2);
    final shouldEnable = onTap != null;
    switch (type) {
      case ActionButtonType.primary:
        return BoxDecoration(
          color: shouldEnable ? Theme.of(context).primaryColor : context.themeColor.n8,
          borderRadius: borderRadius,
        );
      case ActionButtonType.cancel:
        return BoxDecoration(
          color: shouldEnable ? context.themeColor.divider : Colors.grey,
          borderRadius: borderRadius,
        );
      case ActionButtonType.border:
        return BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          border: Border.all(
            color: shouldEnable ? Theme.of(context).primaryColor : Colors.grey,
          ),
          borderRadius: borderRadius,
        );
      case ActionButtonType.errorBorder:
        return BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          border: Border.all(
            color: shouldEnable ? Theme.of(context).colorScheme.error : Colors.grey,
          ),
          borderRadius: borderRadius,
        );
      case ActionButtonType.errorText:
        return null;
      case ActionButtonType.errorFill:
        return BoxDecoration(
          color: shouldEnable ? Theme.of(context).colorScheme.error : Colors.grey,
          borderRadius: borderRadius,
        );
      case ActionButtonType.greyFill:
        return BoxDecoration(color: context.themeColor.divider, borderRadius: borderRadius);
      case ActionButtonType.empty:
        return null;
    }
  }

  Color? _obtainTextColor(BuildContext context) {
    final shouldEnable = onTap != null;
    switch (type) {
      case ActionButtonType.primary:
      case ActionButtonType.errorFill:
        return shouldEnable
            ? Theme.of(context).colorScheme.onPrimary
            : context.themeColorText.subTitleThird;
      case ActionButtonType.border:
        return shouldEnable ? context.themeColor.primaryDark : Colors.grey;
      case ActionButtonType.errorBorder:
        return shouldEnable ? Theme.of(context).colorScheme.error : Colors.grey;
      case ActionButtonType.errorText:
        return shouldEnable ? Theme.of(context).colorScheme.error : Colors.grey;
      case ActionButtonType.cancel:
        return shouldEnable ? context.themeColorText.text4 : Colors.grey;
      case ActionButtonType.empty:
        return shouldEnable ? context.themeColor.primaryDark : context.themeColorText.subTitleThird;
      case ActionButtonType.greyFill:
        // TODO: Handle this case.
        break;
    }
    return null;
  }
}

class ActionButtonV2 extends StatelessWidget {
  const ActionButtonV2({
    Key? key,
    required this.text,
    this.onTap,
    this.type = ActionButtonType.primary,
    this.fontWeight = FontWeight.w400,
    this.padding = Dimens.pad_default,
    this.width,
    this.height,
    this.radius,
    this.expanded = false,
    this.autoSizeGroup,
  }) : super(key: key);

  static const _itemHeight = 48.0;

  final VoidCallback? onTap;
  final String text;
  final ActionButtonType type;
  final FontWeight fontWeight;
  final double padding;
  final double? width;
  final double? height;
  final double? radius;
  final bool expanded;
  final AutoSizeGroup? autoSizeGroup;

  @override
  Widget build(BuildContext context) {
    final textWidget = AutoSizeText(
      text,
      style: defaultTextStyle.semiBold().copyWith(
            fontWeight: fontWeight,
            fontSize: Dimens.font_sp17,
            color: _obtainTextColor(context),
          ),
      maxLines: 1,
      minFontSize: 10,
      group: autoSizeGroup,
    );
    return CardCupertinoEffect(
      onPressed: onTap,
      child: Container(
        height: height ?? _itemHeight,
        width: width,
        padding: EdgeInsets.symmetric(horizontal: padding),
        decoration: _obtainDecoration(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
              children: [
                Flexible(
                  child: textWidget.centered(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration? _obtainDecoration(BuildContext context) {
    final borderRadius = BorderRadius.circular(radius ?? _itemHeight / 2);
    final shouldEnable = onTap != null;
    switch (type) {
      case ActionButtonType.primary:
        return BoxDecoration(
          color: shouldEnable ? Theme.of(context).primaryColor : context.themeColor.n8,
          borderRadius: borderRadius,
        );
      case ActionButtonType.cancel:
        return BoxDecoration(
          color: shouldEnable ? context.themeColor.divider : Colors.grey,
          borderRadius: borderRadius,
        );
      case ActionButtonType.border:
        return BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          border: Border.all(
            color: shouldEnable ? Theme.of(context).primaryColor : Colors.grey,
          ),
          borderRadius: borderRadius,
        );
      case ActionButtonType.errorBorder:
        return BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          border: Border.all(
            color: shouldEnable ? Theme.of(context).colorScheme.error : Colors.grey,
          ),
          borderRadius: borderRadius,
        );
      case ActionButtonType.errorText:
        return null;
      case ActionButtonType.errorFill:
        return BoxDecoration(
          color: shouldEnable ? Theme.of(context).colorScheme.error : Colors.grey,
          borderRadius: borderRadius,
        );
      case ActionButtonType.greyFill:
        return BoxDecoration(color: context.themeColor.divider, borderRadius: borderRadius);
      case ActionButtonType.empty:
        return null;
    }
  }

  Color? _obtainTextColor(BuildContext context) {
    final shouldEnable = onTap != null;
    switch (type) {
      case ActionButtonType.primary:
      case ActionButtonType.errorFill:
        return shouldEnable
            ? Theme.of(context).colorScheme.onPrimary
            : context.themeColorText.subTitleThird;
      case ActionButtonType.border:
        return shouldEnable ? context.themeColor.primaryDark : Colors.grey;
      case ActionButtonType.errorBorder:
        return shouldEnable ? Theme.of(context).colorScheme.error : Colors.grey;
      case ActionButtonType.errorText:
        return shouldEnable ? Theme.of(context).colorScheme.error : Colors.grey;
      case ActionButtonType.cancel:
        return shouldEnable ? context.themeColorText.text4 : Colors.grey;
      case ActionButtonType.empty:
        return shouldEnable ? context.themeColor.primaryDark : context.themeColorText.subTitleThird;
      case ActionButtonType.greyFill:
        // TODO: Handle this case.
        break;
    }
    return null;
  }
}
