import 'package:flutter/foundation.dart';
import 'package:task/core/errors/exceptions.dart';

extension JsonMapX on Map<String, dynamic> {
  T? isType<T>(String key) {
    final value = this[key];
    return value is T
        ? value
        : kDebugMode
        ? throw JsonParseException(
            message:
                'Invalid type of key : $key expected: $T , getting :${this[key].runtimeType}',
          )
        : null;
  }
}

T safeParseJson<T>(
  Map<String, dynamic> json,
  T Function(Map<String, dynamic>) fromJson,
) {
  try {
    return fromJson(json);
  } on AppException {
    rethrow;
  } catch (e) {
    throw JsonParseException(
      message: 'Failed to parse ${T.toString()}: $e',
      originalError: e,
    );
  }
}

List<T> safeParseJsonList<T>(
  List<dynamic> list,
  T Function(Map<String, dynamic>) fromJson,
) {
  try {
    return List<T>.from(list.map((e) => fromJson(e as Map<String, dynamic>)));
  } on AppException {
    rethrow;
  } catch (e) {
    throw JsonParseException(
      message: 'Failed to parse List<${T.toString()}>: $e',
      originalError: e,
    );
  }
}
