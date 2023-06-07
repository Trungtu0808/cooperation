import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:flutter/material.dart';

extension DialogEx on BuildContext{

  Future<dynamic> showErrorPopup({
    required String msg,
    Function()? onTap,
    double buttonsWidth = 150,
    String? title,
    String? actionText,
    double titleTextSize = 18.0,
    bool barrierDismissible = true,
  }) async {
    return await showAlert(
      content: msg,
      title: title ?? 'notify'.tr(),
      barrierDismissible: barrierDismissible,
      positiveAction: AlertAction(
        name: actionText ?? 'ok'.tr(),
        onTap: onTap,
        buttonType: ActionButtonType.primary,
      ),
      expandButtons: false,
      buttonsWidth: buttonsWidth,
      titleTextSize: titleTextSize,
    );
  }

  Future<void> showAlert({
    Widget? icon,
    String? title,
    required String content,
    AlertAction? positiveAction,
    AlertAction? neutralAction,
    AlertAction? negativeAction,
    TextAlign? contentTextAlign,
    double? titleTextSize = 18,
    Color? contentTextColor,
    bool expandButtons = true,
    double? buttonsWidth,
    bool barrierDismissible = true,
  }) async {
    await showDialog(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        final dialog = AppAlertDialog(
          icon: icon,
          title: title,
          content: content,
          positiveAction: positiveAction,
          neutralAction: neutralAction,
          negativeAction: negativeAction,
          contentTextAlign: contentTextAlign,
          titleTextSize: titleTextSize,
          contentTextColor: contentTextColor,
          expandButtons: expandButtons,
          buttonsWidth: buttonsWidth,
        );
        if (barrierDismissible) {
          return dialog;
        } else {
          return WillPopScope(
            child: dialog,
            onWillPop: () => Future.value(false),
          );
        }
      },
    );
  }
}

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog({
    Key? key,
    required this.content,
    this.icon,
    this.title,
    this.positiveAction,
    this.neutralAction,
    this.negativeAction,
    this.contentTextAlign,
    this.titleTextSize,
    this.contentTextColor,
    this.expandButtons = true,
    this.buttonsWidth,
  }) : super(key: key);

  final Widget? icon;
  final String? title;
  final String content;
  final AlertAction? positiveAction;
  final AlertAction? neutralAction;
  final AlertAction? negativeAction;
  final TextAlign? contentTextAlign;
  final double? titleTextSize;
  final Color? contentTextColor;
  final bool expandButtons;
  final double? buttonsWidth;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Align(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: Dimens.pad_XL2),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(Dimens.rad_XL1),
          ),
          padding: Dimens.edge_y_default,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _icon().pSymmetric(h: Dimens.pad_default),
                _title(context).pSymmetric(h: Dimens.pad_default),
                _content(context).pSymmetric(h: Dimens.pad_default),
                Gaps.vGap20,
                Gaps.divider,
                Gaps.vGap16,
                _buttons(context).pSymmetric(h: Dimens.pad_default),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _icon() {
    return icon != null
        ? Padding(
      padding: const EdgeInsets.only(bottom: Dimens.pad_XL),
      child: icon,
    )
        : Container();
  }

  Widget _title(BuildContext context) {
    final textSize = titleTextSize ?? 28;
    return title != null
        ? Padding(
        padding: const EdgeInsets.only(bottom: Dimens.pad_XL),
        child: SizedBox(
          width: double.infinity,
          child: title!.text.bold
              .size(textSize)
              .color(context.themeColorText.text)
              .align(TextAlign.left)
              .make(),
        ))
        : Container();
  }

  Widget _content(BuildContext context) {
    final textColor = contentTextColor ?? context.themeColorText.text6.withOpacity(0.8);
    return SizedBox(
      width: double.infinity,
      child: content.text
          .size(Dimens.font_sp16)
          .align(contentTextAlign ?? TextAlign.left)
          .color(textColor)
          .make(),
    );
  }

  Widget _buttons(BuildContext context) {
    final buttons = <Widget>[
      if (negativeAction != null) throw Exception('Not yet implemented'),
      if (neutralAction != null)
        ActionButton(
          text: neutralAction!.name,
          type: neutralAction!.buttonType ?? ActionButtonType.border,
          onTap: () {
            Navigator.of(context).pop();
            neutralAction?.onTap?.call();
          },
          width: buttonsWidth,
        ),
      if (positiveAction != null)
        ActionButton(
          text: positiveAction!.name,
          onTap: () {
            Navigator.of(context).pop();
            positiveAction?.onTap?.call();
          },
          type: positiveAction!.buttonType ?? ActionButtonType.primary,
          width: buttonsWidth,
        )
    ];
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: buttons.map((e) => expandButtons ? e.expand() : e).toList().withDivider(
        const SizedBox(width: Dimens.pad_L),
      ),
    );
  }
}

class AlertAction {
  AlertAction({required this.name, this.onTap, this.buttonType, this.width});

  final String name;
  final Function? onTap;
  final ActionButtonType? buttonType;
  final double? width;
}