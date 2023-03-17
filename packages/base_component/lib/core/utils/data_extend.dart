extension DataExtendString on String? {
  
  bool isNullOrEmpty() => this == null || this?.trim() == '';

  bool isNotNullOrEmpty() => !isNullOrEmpty();
}