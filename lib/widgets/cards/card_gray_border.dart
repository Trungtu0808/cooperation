import 'package:flutter/material.dart';

import '../../import_file/import_all.dart';

class CardGrayBorder extends StatelessWidget {
  const CardGrayBorder({
    Key? key,
    this.onPressed,
    required this.child,
    this.borderRadius,
    this.backgroundColor,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onPressed;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CardCupertinoEffect(
      onPressed: onPressed,
      child: Container(
        decoration: AppDecor.grayBorder(
          context,
          borderRadius: borderRadius,
          backgroundColor: backgroundColor,
        ),
        clipBehavior: Clip.hardEdge,
        child: child,
      ),
    );
  }
}