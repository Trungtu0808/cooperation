
// Todo-Chi: deal with bottom spacing normal page vs single scroll page
import 'package:base_component/import_all.dart';
import 'package:flutter/material.dart';

class AppSafeArea extends _AppSafeArea {
  const AppSafeArea({
    Key? key,
    required Widget child,
    bool? top,
    bool? bottom,
    bool? left,
    bool? right,
    EdgeInsets? minimum,
    bool? showDivider,
  }) : super(
          key: key,
          child: child,
          top: top,
          bottom: bottom,
          left: bottom,
          right: bottom,
          minimum: minimum,
          showDivider: showDivider,
        );

  factory AppSafeArea.bottom({
    required Widget child,
    EdgeInsets? minimum,
    bool? showDivider,
  }) {
    return AppSafeArea(
      top: false,
      bottom: true,
      left: false,
      right: false,
      minimum: minimum ?? Dimens.bottomMinimum,
      showDivider: showDivider,
      child: child,
    );
  }

  factory AppSafeArea.bottomDivider({
    required Widget child,
    EdgeInsets? minimum,
    bool? showDivider,
  }) {
    return AppSafeArea.bottom(minimum: minimum, showDivider: showDivider ?? true,child: child,);
  }
}

class _AppSafeArea extends StatelessWidget {
  const _AppSafeArea({
    Key? key,
    required this.child,
    this.minimum,
    this.top,
    this.left,
    this.right,
    this.bottom,
    this.showDivider,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets? minimum;
  final bool? top;
  final bool? bottom;
  final bool? left;
  final bool? right;
  final bool? showDivider;

  @override
  Widget build(BuildContext context) {
    var safeArea = SafeArea(
      minimum: minimum ?? Dimens.edge_zero,
      top: top ?? true,
      bottom: bottom ?? true,
      left: left ?? true,
      right: right ?? true,
      child: child,
    );

    if (showDivider == true) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gaps.divider,
          safeArea,
        ],
      ).backgroundColor(context.theme.colorScheme.surface);
    }

    return safeArea;
  }
}
