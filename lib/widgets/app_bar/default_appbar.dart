import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const height = 48.0;
  static const titleFontSizeDefault = Dimens.font_sp22;
  static const titleFontSizeSmall = Dimens.text_L_mid;

  const DefaultAppBar({
    Key? key,
    this.title,
    this.titleWidget,
    this.showDefaultLeading = true,
    this.leading,
    this.onBackTap,
    this.additionalPadding = EdgeInsets.zero,
    this.trailing = const [],
    this.systemUiOverlayStyle = SystemUiOverlayStyle.dark,
    this.titleMaxLines = 2,
    this.titleFontSize = titleFontSizeDefault,
    this.backgroundColor,
  }) : super(key: key);
  final String? title;
  final Widget? titleWidget;
  final bool showDefaultLeading;
  final Widget? leading;
  final VoidCallback? onBackTap;
  final EdgeInsets additionalPadding;
  final List<Widget> trailing;
  final SystemUiOverlayStyle systemUiOverlayStyle;
  final int titleMaxLines;
  final double titleFontSize;
  final Color? backgroundColor;

  @override
  Size get preferredSize => const Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Semantics(
      container: true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: systemUiOverlayStyle,
        child: Container(
          padding: additionalPadding,
          color: backgroundColor ?? Colors.transparent,
          child: Container(
            height: DefaultAppBar.height + statusBarHeight,
            margin: EdgeInsets.only(top: statusBarHeight),
            padding: const EdgeInsets.only(left: Dimens.pad_default),
            child: Align(
              child: SizedBox(
                height: DefaultAppBar.height,
                child: Row(
                  children: [
                    _leading(context),
                    Expanded(
                      child: titleWidget != null
                          ? DefaultTextStyle(
                              style: defaultTextStyle.semiBold().copyWith(
                                fontSize: titleFontSize,
                                color: context.themeColorText.text,
                              ),
                              child: titleWidget!,
                            )
                          : (title ?? '')
                              .textAuto
                              .semiBold
                              .size(titleFontSize)
                              .color(context.themeColorText.text)
                              .maxLines(titleMaxLines)
                              .ellipsis
                              .make(),
                    ),
                    trailing.isNotEmpty ? Gaps.hGap16 : Gaps.hGap12,
                    ...trailing,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _leading(BuildContext context) {
    if (leading != null) {
      return leading!;
    }
    final canPop = context.router.canNavigateBack;
    if (!showDefaultLeading || !canPop) {
      return Container();
    }
    return CardCupertinoEffect(
      onPressed: onBackTap ??
          () {
            context.popRoute();
          },
      child: Padding(
        padding: const EdgeInsets.only(right: Dimens.pad_XS),
        child: Assets.icons.svg.back.svg(
          width: 28,
          height: 28,
          color: context.themeColor.n3,
        ),
      ),
    );
  }
}