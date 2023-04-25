// ignore_for_file: prefer_is_empty

import 'package:base_component/import_all.dart';
import 'package:path/path.dart';

typedef ElementId<T> = Object Function(T element);

extension RxMapExtend<K, V> on RxMap<K, V>? {
  RxMap<K, V>? update(Map<K, V>? list) {
    if (list.isNullOrEmpty() || this == null) {
      return this;
    }

    this!.clear();
    this!.addAll(list!);
    this!.refresh();
    return this;
  }
}

extension MapExtend<K, V> on Map<K, V>? {
  bool isNullOrEmpty() {
    if (this == null || this?.length == 0) return true;
    return false;
  }
  
  bool isNotNullOrEmpty() {
    return !isNullOrEmpty();
  }

  List<T> mapAsList<T>(T Function(K key, V value) mapFunc) {
    final entries = this?.entries ?? [];
    if (entries.isNullOrEmpty()) {
      return [];
    }

    return entries
        .map<T>((entry) => mapFunc(entry.key, entry.value))
        .toList();
  }
}

extension RxListExtend<T> on RxList<T>? {
  RxList<T>? update(List<T>? list) {
    if (this == null) {
      return this;
    }
    this!.clear();
    this!.addAll(list!);
    // this!.refresh();
    return this;
  }
}

extension ListExtend<T> on List<T>? {
  T? getOrNull(int index) {
    if (this == null || index < 0) return null;
    if (index < this!.length) return this![index];
    return null;
  }

  Iterable<T> withoutLast() {
    if (isNullOrEmpty()) return [];

    return this!.sublist(0, this!.length - 1);
  }
}

extension IterableExtension<E> on Iterable<E> {
  static const serverSeparator = ',';


  String joinWithServerSeparator() {
    return this.join(serverSeparator);
  }

  List<String> extractServerList() {
    return split(serverSeparator);
  }
}

extension IterableBasics<E> on Iterable<E>? {
  // ignore: use_function_type_syntax_for_parameters
  List<T> mapAsList<T>(T f(E item)) => this?.map(f).toList() ?? [];

  bool isNullOrEmpty() {
    if (this == null || this?.length == 0) return true;
    return false;
  }

  bool isNotNullOrEmpty() {
    return !isNullOrEmpty();
  }

  Iterable<E> filter(bool Function(E item) conditionMethod) {
    return this?.where(conditionMethod) ?? [];
  }

  E? find(bool Function(E item) conditionMethod) {
    return filterAsList(conditionMethod).firstOrNull();
  }
  
  List<T> filterNotNull<T>() {
    return this?.where((element) => element != null,).cast<T>().toList() ?? [];
  }

  List<E> filterAsList(bool Function(E item) conditionMethod) {
    return filter(conditionMethod).toList();
  }

  String? joinWithoutNull([String separator = ""]) {
    return filterAsList((item) => item != null).join(separator);
  }

  List<E> filterAsListIndex(bool Function(E item, int index) conditionMethod) {
    var i = 0;
    if (isNullOrEmpty()) {
      return [];
    }
    return filter((e) => conditionMethod(e, i++)).toList();
  }

  List<U> mapAsListIndexed<U>(
      U Function(E currentValue, int index) transformer,
      ) {
    return mapIndexed(transformer).toList();
  }

  List<E> searchList(String? searchText, String? Function(E item) mapping) {
    return filterAsList((item) {
      return (mapping(item)
          ?.unsignedLower()
          ?.contains(searchText?.unsignedLower() ?? '') ??
          false);
    });
  }

  // use "Null" to avoid conflict name
  E? firstOrNull() {
    if (this?.length == 0) return null;
    return firstOrElse(() => null as E);
  }

  E? lastOrNull() {
    if (this?.length == 0) return null;
    return lastOrElse(() => null as E);
  }

  E? firstOrElse(E Function() orElse) {
    if (this?.length == 0) return null;
    return this?.firstWhere((_) => true, orElse: orElse);
  }

  E? lastOrElse(E Function() orElse) {
    if (this?.length == 0) return null;
    return this?.lastWhere((_) => true, orElse: orElse);
  }

  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    if (isNullOrEmpty()) {
      return [];
    }
    return this!.map((e) => f(e, i++));
  }

  void forEachIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    if (isNullOrEmpty()) {
      return;
    }
    // ignore: avoid_function_literals_in_foreach_calls
    return this!.forEach((e) => f(e, i++));
  }
}

/// Support primitive data types and custom object with [elementId]
extension NonNullListExtend<T> on List<T> {
  bool containsAll({
    required Iterable<T>? target,
    ElementId<T>? elementId,
  }) {
    final data = this;
    if (data.isEmpty) {
      return false;
    }
    if (target == null) {
      return false;
    }
    if (target.isEmpty) {
      return false;
    }
    if (data.length < target.length) {
      return false;
    }
    List<dynamic> dataIds;
    if (elementId != null) {
      dataIds = data.mapAsList((item) => elementId.call(item));
    } else {
      dataIds = [...data];
    }
    for (final item in target) {
      final itemId = elementId?.call(item) ?? item;
      if (!dataIds.contains(itemId)) {
        return false;
      }
    }
    return true;
  }

  bool containsAnyOf({
    required Iterable<T>? target,
    ElementId<T>? elementId,
  }) {
    final data = this;
    if (data.isEmpty) {
      return false;
    }
    if (target == null) {
      return false;
    }
    if (target.isEmpty) {
      return false;
    }
    List<dynamic> dataIds;
    if (elementId != null) {
      dataIds = data.mapAsList((item) => elementId.call(item));
    } else {
      dataIds = [...data];
    }
    for (final item in target) {
      final itemId = elementId?.call(item) ?? item;
      if (dataIds.contains(itemId)) {
        return true;
      }
    }
    return false;
  }
}