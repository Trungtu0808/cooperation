import 'package:app_chat_firebase/import_file/import_all.dart';

K? intEnumDecodeNullableAny<K extends Enum>({
  required Map<K, int> enumValues,
  required dynamic source,
  Enum? unknownValue = JsonKey.nullForUndefinedEnumValue
}){
  int? intValues;

  if (source is String){
    intValues = int.tryParse(source);

  } else if (source is int) {
    intValues = source;
  }
  return $enumDecodeNullable(enumValues, intValues, unknownValue: unknownValue);
}