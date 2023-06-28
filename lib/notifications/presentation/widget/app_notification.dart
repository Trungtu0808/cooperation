import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:flutter/material.dart';

class AppNotification extends StatelessWidget {
  const AppNotification({
    super.key,
    required this.title,
    this.subtitle,
    this.onPressed,
  });

  final String title;
  final String? subtitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.only(
          left: Dimens.pad_default,
          top: MediaQuery.of(context).padding.top,
          right: Dimens.pad_default,
        ),
        child: CardCupertinoEffect(
          onPressed: onPressed,
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 72,
            ),
            decoration: BoxDecoration(
                color: context.themeColor.backgroundSecondary,
                borderRadius: BorderRadius.circular(Dimens.rad),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 2),
                      blurRadius: 2,
                      color: Colors.black.withOpacity(0.2))
                ]),
            child: Padding(
              padding: const EdgeInsets.all(Dimens.pad_XS),
              child: subtitle?.isNotEmpty == true
                  ? _withSubtitleWidget(context: context, subtitle: subtitle!)
                  : _titleOnlyWidget(context: context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleOnlyWidget({required BuildContext context}) {
    return Center(
      child: Row(
        children: [
          Assets.icons.png.appleLogo.image(
            width: 40,
            height: 40,
          ),
          Gaps.hGap12,
          title.text.semiBold.color(context.themeColorText.text).make().expand(),
        ],
      ),
    );
  }

  Widget _withSubtitleWidget({required BuildContext context, required String subtitle}) {
    return Row(
      children: [
        Assets.icons.png.appleLogo.image(
          width: 40,
          height: 40,
        ),
        Gaps.hGap12,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title.text.semiBold.color(context.themeColorText.text).make(),
              Gaps.vGap8,
              subtitle.text.color(context.themeColorText.subTitle).maxLines(2).ellipsis.make()
            ],
          ),
        ),
      ],
    );
  }
}