import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:flutter/material.dart';


const defaultTextStyle = TextStyle(
  fontFamily: FontFamily.inter,
  fontSize: 16,
  fontWeight: FontWeight.normal,
  color: Colors.black,
);

extension TextStyleExtension on TextStyle {
  TextStyle semiBold() {
    return copyWith(fontWeight: FontWeight.w700);
  }
}