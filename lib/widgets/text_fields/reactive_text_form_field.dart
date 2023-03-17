import 'package:flutter/material.dart';
import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:flutter/services.dart';

class ReactiveTextFormField<T> extends StatefulWidget {
  static const defaultContentPadding = TextFieldOutline.defaultContentPadding;
  static const contentPaddingMedium = TextFieldOutline.contentPaddingMedium;

  const ReactiveTextFormField({
    Key? key,
    this.formControlName,
    this.formControl,
    this.valueAccessor,
    this.validationMessages,
    this.showErrors,
    this.label,
    this.required = true,
    this.hintText,
    this.contentPadding = ReactiveTextFormField.defaultContentPadding,
    this.maxLines,
    this.minLines,
    this.textInputAction,
    this.obscureText = false,
    this.suffix,
    this.prefix,
    this.prefixMaxWidth,
    this.suffixMaxWidth,
    this.textAlign,
    this.textInputType,
    this.formatter,
    this.onSubmit,
    this.focusNode,
    this.enabled,
    this.backgroundColor,
    this.borderColor,
    this.enableSameBorder = false, this.onChange, this.textStyle, this.maxLength, this.autoFocus,
    this.showClear,
    this.isShowError = false,
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
  final int? maxLines;
  final int? minLines;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Widget? suffix;
  final Widget? prefix;
  final double? prefixMaxWidth;
  final TextAlign? textAlign;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? formatter;
  final Function(String)? onSubmit;
  final FocusNode? focusNode;
  final bool? enabled;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool enableSameBorder;
  final double? suffixMaxWidth;
  final Function(String)? onChange;
  final TextStyle? textStyle;
  final int? maxLength;
  final bool? autoFocus;
  final bool? showClear;
  final bool isShowError;

  @override
  State<ReactiveTextFormField<T>> createState() => _ReactiveTextFormFieldState<T>();
}

class _ReactiveTextFormFieldState<T> extends State<ReactiveTextFormField<T>> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormField<T, String>(
      formControlName: widget.formControlName,
      formControl: widget.formControl,
      valueAccessor: widget.valueAccessor,
      validationMessages: widget.validationMessages,
      builder: (state) {
        if (state.value != _textController.text && state.value != null) {
          _textController.text = state.value!;
        }
        return TextFieldOutline(
          isShowError: widget.isShowError,
          errorText:  widget.isShowError ? state.errorText ?? '' : null,
          enableSameBorder: widget.enableSameBorder,
          borderColor: widget.borderColor,
          backgroundColor: widget.backgroundColor,
          focusNode: widget.focusNode,
          controller: _textController,
          inputFormatters: widget.formatter ?? [],
          keyboardType: widget.textInputType,
          label: widget.label,
          required: widget.required,
          hintText: widget.hintText,
          contentPadding: widget.contentPadding,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          textInputAction: widget.textInputAction,
          onChanged: (string) {
            widget.onChange?.call(string);
            state.didChange(string);
          },
          obscureText: widget.obscureText,
          suffix: widget.suffix,
          prefix: widget.prefix,
          prefixMaxWidth: widget.prefixMaxWidth,
          suffixMaxWidth: widget.suffixMaxWidth,
          textAlign: widget.textAlign,
          onFieldSubmitted: (controller, value) {
            widget.onSubmit?.call(value);
          },
          textStyle: widget.textStyle,
          enabled: widget.enabled ?? !state.control.disabled,
          autoFocus: widget.autoFocus ?? false,
          showClear: widget.showClear ?? true,
        );
      },
    );
  }
}