import 'dart:io';

import 'package:base_component/import_all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTopLayout extends _BaseAppTopLayout {
  const AppTopLayout({
    Key? key,
    required Widget topWidget,
    required Widget bottomWidget,
    required ValueNotifier<bool> showTopWidget,
  }) : super(
          key: key,
          topWidget: topWidget,
          bottomWidget: bottomWidget,
          showTopWidget: showTopWidget,
        );

  /// Show loading indicator and ignore tap to [child]
  factory AppTopLayout.loadingOnTop({
    required Widget child,
    required ValueNotifier<bool> isLoading,
    Color? indicatorColor,
  }) {
    return AppTopLayout(
      topWidget: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {},
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: AppLoadingIndicator(color: indicatorColor),
          ),
        ),
      ),
      bottomWidget: child,
      showTopWidget: isLoading,
    );
  }
}

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? CupertinoActivityIndicator(radius: 16.0, color: color) :
    CircularProgressIndicator(backgroundColor: color,);
  }
}

class FullScreenAppLoadingIndicator extends StatelessWidget {
  const FullScreenAppLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {},
      child: const Center(
        child: AppLoadingIndicator(),
      ),
    );
  }
}

class _BaseAppTopLayout extends StatelessWidget {
  final Widget topWidget;
  final Widget bottomWidget;
  final ValueNotifier<bool> showTopWidget;

  const _BaseAppTopLayout({
    Key? key,
    required this.topWidget,
    required this.bottomWidget,
    required this.showTopWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        bottomWidget,
        ValueListenableBuilder<bool>(
          valueListenable: showTopWidget,
          builder: (context, shouldShow, __) {
            return shouldShow ? topWidget : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

class LoadingWrapper extends StatelessWidget {
  const LoadingWrapper({
    Key? key,
    this.isLoading = true, required this.child,
  }) : super(key: key);
  
  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var topWidget = AppLoading.defaultLoadingCenter();
    return Stack(
      children: [
        IgnorePointer(
          ignoring: isLoading,
          child: child,
        ),
        if (isLoading)
          Positioned.fill(
            child: topWidget,
          ),
      ],
    );
  }
}
