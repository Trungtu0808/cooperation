import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:app_chat_firebase/widgets/stream/stream_listener.dart';
import 'package:flutter/material.dart';

class ReactiveControlListener<T> extends StatelessWidget {
  const ReactiveControlListener({
    super.key,
    this.controlName,
    this.formControl,
    required this.onData,
    required this.child,
  });

  final String? controlName;
  final FormControl<T>? formControl;
  final StreamOnDataListener<T> onData;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final control =
        formControl ?? ReactiveForm.of(context)?.findControl(controlName ?? '') as FormControl<T>?;
    final stream = control?.valueChanges;
    if (stream == null || stream is! Stream<T>) {
      return child;
    }
    return StreamListener<T>(
      onData: onData,
      stream: stream,
      child: child,
    );
  }
}
