
import 'package:flutter/cupertino.dart';

import '../import_file/import_all.dart';

typedef _ObjectGenerator<T> = T Function(Map<String, dynamic>);

class UserSecureStorage {
  bool _isInitialized = false;

  Future<void> init()async{
    if (_isInitialized){
      return;
    }

  }

  late Box _box;
}