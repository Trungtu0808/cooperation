

import 'package:base_component/import_all.dart';
import 'package:flutter/material.dart';

class DismissKeyboard extends StatelessWidget {
  final Widget child;
  const DismissKeyboard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is UserScrollNotification) {
          AppUtils.dismissKeyboard(context);
        }
        return false;
      },
      child: GestureDetector(
        onTap: () {
          AppUtils.dismissKeyboard(context);
        },

        child: child,
      ),
    );
  }

}