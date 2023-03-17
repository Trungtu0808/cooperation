import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:flutter/material.dart';

class ReactiveStatusListenableBuilderValue<T> extends StatelessWidget {
  const ReactiveStatusListenableBuilderValue({
    super.key,
    required this.formControlName,
    required this.builder,
  });

  final String formControlName;
  final Widget Function(
    BuildContext context,
    AbstractControl<T> control,
    T? value,
    Widget? child,
  ) builder;

  @override
  Widget build(BuildContext context) {
    return ReactiveStatusListenableBuilderValue(
      builder: (
        BuildContext context,
        AbstractControl<dynamic> control,
        value,
        Widget? child,
      ) {
        var value = control.value as T?;
        return builder(context, control as AbstractControl<T>, value, child);
      },
      formControlName: formControlName,
    );
  }
}
