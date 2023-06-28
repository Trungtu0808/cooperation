import 'package:flutter/material.dart';

class ActionIconButton extends StatelessWidget {
  const ActionIconButton({
    Key? key,
    required this.onTab,
    required this.icon,
    this.iconColor,
    this.iconSize,
  }) : super(key: key);

  final VoidCallback onTab;
  final IconData icon;
  final Color? iconColor;
  final double? iconSize;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onTab(), icon: Icon(icon), color:iconColor ?? Colors.green,
      iconSize: iconSize ?? 50.0,
    );
  }
}
