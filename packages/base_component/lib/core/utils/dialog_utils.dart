import 'dart:ui';

import 'package:base_component/import_all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheetOption {
  late String label;
  dynamic callback;
}

class DialogReturnMsg {
  DialogReturnMsg._();

  static String confirmDelete = 'confirmDelete';
  static String ok = 'ok';
  static String cancel = 'cancel';
  static String dismiss = 'dismiss';
}

class DialogUtils {
  DialogUtils._();

  static Future<String?> showWidgetDialogWithBackground(BuildContext context,
      {required Widget child}) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: Dimens.edge_default,
          child: child,
        );
      },
    );
  }

  static Future<String?> showWidgetDialog(BuildContext context,
      {required Widget child, bool blurBackground = false}) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        final dialogWidget = Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          alignment: Alignment.center,
          child: child,
        );
        if (blurBackground) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: dialogWidget,
          );
        }
        return dialogWidget;
      },
    );
  }

  static Future<String?> showMaterialDialog(
    BuildContext context, {
    String? title,
    Widget? child,
    String? content,
    String? positiveLabel,
    Function()? positive,
    String? negativeLabel,
    Function()? negative,
    String? deleteLabel,
    Function()? delete,
    bool showAction = true,
    ShapeBorder? shape,
    EdgeInsetsGeometry? contentPadding,
    bool barrierDismissible = true,
  }) {
    actionBuilder(context) {
      final action = <Widget>[];
      const edgeInsets = EdgeInsets.symmetric(vertical: 4, horizontal: 12);

      if (negative != null) {
        action.add(Btn.roundCorner(
          btnType: BtnType.GRAY,
          padding: edgeInsets,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(DialogReturnMsg.cancel);
            negative.call();
          },
          child: Text(negativeLabel ?? 'close'.tr),
        ));
      }

      if (delete != null) {
        action.add(Btn.roundCorner(
          btnType: BtnType.DELETE,
          padding: edgeInsets,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(DialogReturnMsg.confirmDelete);
            delete.call();
          },
          child: Text(deleteLabel ?? 'confirm'.tr),
        ).expand());
      } else if (showAction) {
        action.add(Btn.roundCorner(
          padding: edgeInsets,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(DialogReturnMsg.ok);
            positive?.call();
          },
          child: Text(positiveLabel ?? 'OK'.tr),
        ));
      }
      return action;
    }

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        final action = actionBuilder(context);

        return AlertDialog(
          shape: shape,
          title: title != null
              ? Text(
                  title,
                  style: context.themeText.text.copyWith(fontWeight: FontWeight.w600),
                )
              : null,
          content: child ??
              (content != null
                  ? Text(content,
                      style: context.textTheme.bodyMedium!.copyWith(fontSize: Dimens.text))
                  : null),
          actions: [
            Row(
              children: [
                ...action.mapAsList((item) => item.expand()),
              ].withDivider(Gaps.hGap8),
            ).px8().pb4()
          ],
          actionsAlignment: MainAxisAlignment.center,
          buttonPadding: action.isNullOrEmpty() ? Dimens.edge_zero : null,
          titlePadding: const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 0.0),
          contentPadding: contentPadding ?? const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 16.0),
        );
      },
    );
  }

  static Future<String?> showAlertDialog(
    BuildContext context, {
    String? title,
    Widget? titleWidget,
    String? content,
    Widget? contentWidget,
    String? positiveLabel,
    Function()? positive,
    String? negativeLabel,
    Function()? negative,
    String? deleteLabel,
    Function()? delete,
    TextAlign? textAlign,
    bool barrierDismissible = true,
  }) {
    actionBuilder(context) {
      final action = <Widget>[];

      if (negative != null) {
        action.add(CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(DialogReturnMsg.cancel);
            negative.call();
          },
          child: Text(negativeLabel ?? 'close'.tr),
        ));
      }

      if (delete != null) {
        action.add(CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(DialogReturnMsg.confirmDelete);
            delete.call();
          },
          isDestructiveAction: true,
          child: Text(negativeLabel ?? 'confirm'.tr),
        ));
      } else {
        action.add(CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop(DialogReturnMsg.ok);
            positive?.call();
          },
          child: Text(positiveLabel ?? 'OK'.tr),
        ).objectCenter());
      }
      return action;
    }

    return showDialog<String>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: titleWidget ??
              (title != null
                  ? Text(
                      title,
                      style: context.theme.textTheme.headline6,
                    )
                  : null),
          content: contentWidget ??
              (content != null
                  ? Text(content,
                      style: context.textTheme.bodyText2!.copyWith(fontSize: Dimens.text),
                      textAlign: textAlign)
                  : null),
          actions: actionBuilder(context),
        );
      },
    );
  }

  static pop(BuildContext context) {
    Navigator.pop(context);
  }
}

extension DialogEx on BuildContext {
  Future<String?> showAlertDialog(
    BuildContext context, {
    String? title,
    Widget? titleWidget,
    String? content,
    Widget? contentWidget,
    String? positiveLabel,
    Function()? positive,
    String? negativeLabel,
    Function()? negative,
    String? deleteLabel,
    Function()? delete,
    TextAlign? textAlign,
    bool barrierDismissible = true,
  }) {
    actionBuilder(context) {
      final action = <Widget>[];

      if (negative != null) {
        action.add(CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(DialogReturnMsg.cancel);
            negative.call();
          },
          child: Text(negativeLabel ?? 'close'.tr),
        ));
      }

      if (delete != null) {
        action.add(CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(DialogReturnMsg.confirmDelete);
            delete.call();
          },
          isDestructiveAction: true,
          child: Text(negativeLabel ?? 'confirm'.tr),
        ));
      } else {
        action.add(CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop(DialogReturnMsg.ok);
            positive?.call();
          },
          child: Text(positiveLabel ?? 'OK'.tr),
        ).objectCenter());
      }
      return action;
    }

    return showDialog<String>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: titleWidget ??
              (title != null
                  ? Text(
                      title,
                      style: context.theme.textTheme.titleLarge,
                    )
                  : null),
          content: contentWidget ??
              (content != null
                  ? Text(content,
                      style: context.textTheme.bodyMedium!.copyWith(fontSize: Dimens.text),
                      textAlign: textAlign)
                  : null),
          actions: actionBuilder(context),
        );
      },
    );
  }
}
