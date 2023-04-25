import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:flutter/material.dart';

class ReactivePasswordTextFormField<T> extends StatefulWidget {
  static const defaultContentPadding = TextFieldOutline.defaultContentPadding;
  static const contentPaddingMedium = TextFieldOutline.contentPaddingMedium;

  const ReactivePasswordTextFormField({
    Key? key,
    this.formControlName,
    this.formControl,
    this.valueAccessor,
    this.validationMessages,
    this.showErrors,
    this.label,
    this.required = false,
    this.hintText,
    this.contentPadding = defaultContentPadding,
    this.textInputAction,
    this.onSubmit,
    this.focusNode,
    this.isShowError = false,
    this.maxLines,
  }) : super(key: key);

  final String? formControlName;
  final FormControl<T>? formControl;
  final ControlValueAccessor<T, String>? valueAccessor;
  final Map<String, ValidationMessageFunction>? validationMessages;
  final ShowErrorsFunction? showErrors;
  final String? label;
  final bool required;
  final String? hintText;
  final EdgeInsets contentPadding;
  final TextInputAction? textInputAction;
  final Function(String)? onSubmit;
  final FocusNode? focusNode;
  final bool isShowError;
  final int? maxLines;

  @override
  State<ReactivePasswordTextFormField<T>> createState() => _ReactivePasswordTextFormFieldState<T>();
}

class _ReactivePasswordTextFormFieldState<T> extends State<ReactivePasswordTextFormField<T>> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return ReactiveTextFormField(
          isShowError: widget.isShowError,
          focusNode: widget.focusNode,
          formControlName: widget.formControlName,
          formControl: widget.formControl,
          valueAccessor: widget.valueAccessor,
          validationMessages: widget.validationMessages,
          showErrors: widget.showErrors,
          contentPadding: widget.contentPadding,
          label: widget.label,
          required: widget.required,
          hintText: widget.hintText,
          maxLines: widget.maxLines,
          textInputAction: widget.textInputAction,
          obscureText: !_passwordVisible,
          onSubmit: widget.onSubmit,
          suffix: IconButton(
            onPressed: (){
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
            iconSize: 24,
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: context.themeColorText.subTitleThird,
            ),
          ),
        );
      }
    );
  }
}
