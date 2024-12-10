import 'dart:developer';
import 'package:dio/dio.dart';

import '../resources/result.dart';

Future<Result<T>> execute<T>(
  Future<T> Function() function, {
  String tag = '',
  // required Function(T) onSuccess,
}) async {
  try {
    final result = await function();

    return Success(result);
  } catch (e, stackTrace) {
    log('$tag execute: ${e.toString()}', error: e, stackTrace: stackTrace);
    if (e is DioException) {
      print('DioException: ${e.response?.data}');
      return Failure(e.message ?? "Đã có lỗi xảy ra");
    }
    return Failure(e.toString());
  }
}
//execute v2
