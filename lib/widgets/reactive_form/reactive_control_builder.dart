import 'package:base_component/imports/packages_import.dart';
import 'package:flutter/material.dart';

class ReactiveControlBuilder<T> extends StatelessWidget {
  const ReactiveControlBuilder({
    super.key,
    required this.controlName,
    this.child,
    required this.builder,
  });

  final String controlName;
  final Widget? child;
  final Widget Function(Widget? child, T? value) builder;

  @override
  Widget build(BuildContext context) {
    return ReactiveStatusListenableBuilder(
      formControlName: controlName,
      builder: (context, control, child) {
        var value = control.value as T?;
        return builder(child, value);
      },
    );
  }
}
