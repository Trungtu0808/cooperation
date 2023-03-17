
import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TextFieldOutlineState { NORMAL, NOT_EMPTY, NOT_VALID }

class TextFieldOutline extends StatefulWidget {
  static const defaultContentPadding = EdgeInsets.symmetric(vertical: 12, horizontal: 12);
  static const contentPaddingMedium = EdgeInsets.symmetric(vertical: 14, horizontal: 12);
  static const contentPaddingNoHorizontal = EdgeInsets.symmetric(vertical: 14, horizontal: 0);

  const TextFieldOutline({
    Key? key,
    this.label,
    this.required = false,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.autoFocus = false,
    this.iconData,
    this.radius = Dimens.rad_L,
    this.hintText,
    this.validator,
    this.onSaved,
    this.showClear = false,
    this.keyboardType,
    this.focusNode,
    this.borderWidth = 1,
    this.contentPadding = defaultContentPadding,
    this.labelText,
    this.colorOnFill = false,
    this.initialValue,
    this.onChanged,
    this.onChangedDelay,
    this.onFocusChange,
    this.backgroundColor,
    this.iconSize,
    this.controller,
    this.timerDuration = const Duration(seconds: 1),
    this.maxLines,
    this.minLines,
    this.iconPadding,
    this.hintStyle,
    this.enabled,
    this.iconDataTail,
    this.helperText,
    this.maxLength,
    this.borderColor,
    this.selectedBorderColor,
    this.suffix,
    this.prefix,
    this.clearBtnBuilder,
    this.textInputAction,
    this.showTopMaxLength = false,
    this.textStyle,
    this.labelStyle,
    this.showCounter = false,
    this.keepClearOnUnFocus,
    this.suffixMaxWidth,
    this.prefixMaxWidth,
    this.obscureText = false,
    this.inputFormatters = const [],
    this.textAlign,
    this.readOnly = false,
    this.enableSameBorder = false, 
    this.onClearPressed,
    this.isShowError = false,
    this.errorText,
  }) : super(key: key);

  final String? label;
  final bool required;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? initialValue;
  final Duration timerDuration;
  final bool? enabled;
  final bool? keepClearOnUnFocus;
  final bool obscureText;
  final bool readOnly;
  final bool enableSameBorder;

  final TextEditingController? controller;

  // Event
  final VoidCallback? onClearPressed;
  final ValueChanged<String>? onChangedDelay;
  final ValueChanged<String>? onChanged;
  final Function(bool hasFocus, String value)? onFocusChange;
  final FormFieldValidator<String>? validator;

  //this function call when formKey.currentState?.save() is invoked
  final FormFieldSetter<String>? onSaved;

  // Focus
  final bool autoFocus;
  final FocusNode? focusNode;

  // Style Data
  final Widget? prefix;
  final Widget? suffix;
  final double? suffixMaxWidth;
  final double? prefixMaxWidth;
  final Widget Function(TextEditingController controller, bool showCLear)? clearBtnBuilder;
  final bool colorOnFill;
  final TextInputType? keyboardType;
  final bool showClear;
  final int? maxLines;
  final int? minLines;
  final IconData? iconData;
  final IconData? iconDataTail;
  final EdgeInsetsGeometry? iconPadding;
  final TextInputAction? textInputAction;

  // Max Length
  final int? maxLength;
  final bool showTopMaxLength;
  final bool showCounter;

  // Style
  final double? iconSize;
  final double radius;
  final double borderWidth;
  final Color? borderColor;
  final Color? selectedBorderColor;
  final EdgeInsetsGeometry? contentPadding;
  final Color? backgroundColor;
  final TextStyle? hintStyle;
  final VoidCallback? onEditingComplete;
  final void Function(TextEditingController controller, String value)? onFieldSubmitted;
  final List<TextInputFormatter> inputFormatters;
  final TextAlign? textAlign;
  final bool isShowError;
  final String? errorText;

  @override
  State createState() => _TextFieldOutlineState();
}

class _TextFieldOutlineState extends State<TextFieldOutline> {
  // TextFieldOutlineState _state = TextFieldOutlineState.NORMAL;

  bool _showingClearBtn = false;

  late FocusNode _focusNode;
  late TextEditingController _controller;
  final _fieldKey = GlobalKey<FormFieldState>();

  // Length count
  final lengthCountLD = 0.obs;

  // Timer for onChange
  Timer? _timer;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue);
    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(_onFocusChange);
    //_controller.addListener(_onTextChange);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TextFieldOutline oldWidget) {
    if (widget.initialValue != null && _controller.text.isNullOrEmpty() == true) {
      _controller = widget.controller ?? TextEditingController(text: widget.initialValue);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _onTextChange() {
    widget.onChanged?.call(_controller.text);

    // Hide/Show clear button when text null or not null
    if (widget.showClear && mounted) {
      setState(() {
        _showingClearBtn = _willShowClearBtn();
      });
    }

    // Assign callback text change event
    if (widget.onChangedDelay != null) {
      _textChangedWithTimer(_controller.text);
    }

    if (widget.showTopMaxLength) {
      lengthCountLD.value = _controller.text.length;
    }
  }

  void _textChangedWithTimer(String val) {
    _timer?.cancel();
    _timer = Timer(widget.timerDuration, () {
      widget.onChangedDelay!(_controller.text);
    });
  }

  void _onFocusChange() {
    // _validateEmpty();

    // Assign callback focus event
    if (widget.onFocusChange != null) {
      widget.onFocusChange!(_focusNode.hasFocus, _controller.text);
    }
    // Validate on lost focus
    if (widget.validator != null) {
      if (!_focusNode.hasFocus) {
        _fieldKey.currentState?.validate();
      }
    }
    // Hide/Show clear on focus change
    if (widget.showClear) {
      setState(() {
        _showingClearBtn = _willShowClearBtn();
      });
    }
  }

  bool _willShowClearBtn() {
    return !(!widget.showClear ||
        (_controller.text.isNullOrEmpty()) ||
        !(_focusNode.hasFocus || widget.keepClearOnUnFocus == true));
  }

  // void _validateEmpty() {
  //   if (_state == TextFieldOutlineState.NOT_VALID) return;
  //
  //   if (_focusNode.hasFocus && _state != TextFieldOutlineState.NOT_EMPTY) {
  //     _state = TextFieldOutlineState.NOT_EMPTY;
  //   } else if (!_focusNode.hasFocus &&
  //       (_controller.text.isNullOrEmpty())) {
  //     _state = TextFieldOutlineState.NORMAL;
  //   }
  // }

  @override
  void dispose() {
    _timer?.cancel();
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    if (widget.controller == null) {
      _controller.dispose();
    }
    lengthCountLD.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textFormField = TextFormField(

      onChanged: (text) => widget.onChanged?.call(text),
      inputFormatters: widget.inputFormatters,
      key: _fieldKey,
      obscureText: widget.obscureText,
      textInputAction: widget.textInputAction,
      autofocus: widget.autoFocus,
      onEditingComplete: widget.onEditingComplete,
      textAlign: widget.textAlign ?? TextAlign.start,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      controller: _controller,
      focusNode: _focusNode,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      keyboardType: widget.keyboardType,
      maxLength: widget.maxLength,
      style: widget.textStyle,
      onFieldSubmitted: (str) => widget.onFieldSubmitted?.call(_controller, str),
      validator: widget.validator == null
          ? null
          : (value) {
              var rs = widget.validator!(value);
              return rs;
            },
      onSaved: widget.onSaved,
      decoration: _getInputDecoration(context),
      buildCounter: widget.showTopMaxLength == true || !widget.showCounter
          ? (_, {required currentLength, maxLength, required isFocused}) => null
          : null,

    );
    final errorText = widget.isShowError && widget.errorText.isNotNullOrEmpty() ?
      Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: (widget.errorText ?? '').text.size(Dimens.font_sp15).color(Colors.brown).make(),
    ): Gaps.empty;

    if (widget.showTopMaxLength && widget.showCounter) {
      return Column(
        children: [
          Obx(() =>
                  '${lengthCountLD.value}/${widget.maxLength}'.text.textXS.caption(context).make())
              .objectCenterRight(),
          Gaps.vGap4,
          Align(
              alignment: Alignment.centerLeft,
              child: errorText),
          if (widget.isShowError)
            Gaps.vGap4,
          textFormField,
        ],
      );
    }
    if (widget.label != null) {
      return Column(
        children: [
          Row(
            children: [
              Flexible(
                child: (widget.label ?? '')
                    .text
                    .size(Dimens.text)
                    .color(context.themeColorText.text)
                    .make(),
              ),
              if (widget.required)
                '*'
                    .text
                    .size(Dimens.font_sp14)
                    .color(context.themeColorText.focused)
                    .semiBold
                    .make(),
            ],
          ),
          Gaps.vGap4,
          Align(
              alignment: Alignment.centerLeft,
              child: errorText),
          if (widget.isShowError)
            Gaps.vGap4,
          textFormField,
        ],
      );
    }

    return textFormField;
  }

  InputDecoration _getInputDecoration(BuildContext context) {
    final borderRadius = BorderRadius.circular(widget.radius);

    final border = OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: widget.borderColor ?? context.theme.dividerColor,
        ));

    return InputDecoration(
        helperText: widget.helperText,
        contentPadding: widget.contentPadding,
        isDense: widget.contentPadding != null ? true : false,

        // Border
        enabledBorder: border,
        border: border,
        focusedBorder: widget.enableSameBorder ? border : border.copyWith(
          borderSide: border.borderSide.copyWith(
            color: widget.selectedBorderColor ?? context.theme.primaryColor,
          ),
        ),
        disabledBorder: border,

        //
        filled: true,
        hintStyle: widget.hintStyle ??
            defaultTextStyle.copyWith(
              color: Theme.of(context).hintColor,
              fontSize: Dimens.text,
            ),
        hintText: widget.hintText,
        labelText: widget.labelText,
        labelStyle: widget.labelStyle,
        fillColor: widget.backgroundColor ?? Colors.transparent,

        // Icons
        prefixIcon: _buildPrefixWidget(),
        prefixIconConstraints:  BoxConstraints(maxWidth: widget.prefixMaxWidth ?? 62),
        suffixIcon: _buildSuffixButton(),
        suffixIconConstraints: BoxConstraints(maxWidth: widget.suffixMaxWidth ?? 62),
    );
  }

  Widget? _buildPrefixWidget() {
    var iconData = widget.iconData;
    var iconSize = widget.iconSize;
    var iconPadding = widget.iconPadding;

    // final Color colorItem;
    // if (_state == TextFieldOutlineState.NOT_VALID) {
    //   colorItem = Theme.of(context).errorColor;
    // } else if ((_state == TextFieldOutlineState.NOT_EMPTY &&
    //     widget.colorOnFill) ||
    //     _focusNode.hasFocus) {
    //   colorItem = Theme.of(context).primaryColor;
    // } else {
    //   colorItem = Theme.of(context).lightGrey();
    // }

    return iconData != null
        ? _PrefixIcon(
            iconPadding: iconPadding,
            iconData: iconData,
            iconSize: iconSize,
            // colorItem: colorItem
          )
        : widget.prefix;
  }

  Widget? _buildSuffixButton() {
    if (widget.suffix != null) {
      return widget.suffix;
    }

    if (widget.clearBtnBuilder != null) {
      return widget.clearBtnBuilder!(_controller, _showingClearBtn);
    }
    if (_showingClearBtn) {
      return BtnInputClear(onPress: () {
        _controller.clear();
        widget.onClearPressed?.call();
      });
    }
    return null;
  }
}

class _PrefixIcon extends StatelessWidget {
  const _PrefixIcon({
    Key? key,
    required this.iconPadding,
    required this.iconData,
    required this.iconSize,
    // required this.colorItem,
  }) : super(key: key);

  final EdgeInsetsGeometry? iconPadding;
  final IconData? iconData;
  final double? iconSize;

  // final Color? colorItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: iconPadding ?? const EdgeInsets.only(left: 10, right: 10),
      child: Icon(
        iconData,
        size: iconSize ?? 24,
        // color: colorItem,
      ),
    );
  }
}

class BtnInputClear extends StatelessWidget {
  const BtnInputClear({
    Key? key,
    required this.onPress,
  }) : super(key: key);

  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return BtnCircleIcon(
      CupertinoIcons.xmark_circle_fill,
      onPress: onPress,
      iconSize: 20,
      backgroundColor: Colors.transparent,
      iconColor: context.themeColorText.subTitleThird,
    ).px4();
  }
}