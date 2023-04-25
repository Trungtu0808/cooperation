import 'package:base_component/import_all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLoading {

  static Widget materialLoading({
    bool isLoading = true,
    bool center = true,
    double? strokeWidth,
    Color? color,
  }) {
    var loading =
        isLoading ? CircularProgressIndicator(color: color) : Gaps.empty;

    return center ? loading.centered() : loading;
  }

   static Widget materialLoadingBox(BuildContext context,
      {bool isLoading = true,
      double? strokeWidth,
      Color? color,
      double size = 40,
      double? height,
      double? width,
      bool center = true}) {
    if (!isLoading) return Gaps.empty;

    return SizedBox(
        height: height ?? size,
        width: width ?? size,
        child: AppLoading.materialLoading(
          isLoading: isLoading,
          strokeWidth: strokeWidth,
          color: color ?? context.theme.onPrimary(),
          center: center,
        ));
  }

  static Widget defaultLoading({
    bool isLoading = true,
    bool center = true,
    double? strokeWidth,
    Color? color,
  }) {
    var loading = isLoading
        ? CupertinoActivityIndicator(
      color: color,
    )
        : Gaps.empty;

    return center ? loading.centered() : loading;
  }

  static Widget defaultLoadingCenter({
    bool isLoading = true,
    double? strokeWidth,
    Color? color,
  }) {
    return defaultLoading(
      strokeWidth: strokeWidth,
      color: color,
      isLoading: isLoading,
      center: true,
    );
  }
}