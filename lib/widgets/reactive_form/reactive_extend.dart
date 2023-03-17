import 'package:base_component/import_all.dart';
import 'package:flutter/material.dart';

extension ReactiveFormExtend on ReactiveForm {
  static FormControl<T>? getControl<T>(BuildContext context, String controlName) =>
      ReactiveForm.of(context)?.findControl(controlName) as FormControl<T>?;
}

extension ReactiveFormContextEx on BuildContext {
  FormControl<T>? getControl<T>(String controlName) =>
      ReactiveForm.of(this)?.findControl(controlName) as FormControl<T>?;
}
