import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:oneship_merchant_app/core/resources/data_state.dart';
import 'package:retrofit/retrofit.dart';
import 'dart:io' show HttpStatus;


abstract class BaseApiRepository {
  @protected
  Future<DataState<T>> getStateOf<T>({
    required Future<HttpResponse> Function() request,
  }) async {
    try {
      final httpResponse = await request();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        throw DioException(
            requestOptions: httpResponse.response.requestOptions,
            response: httpResponse.response);
      }
    } on DioException catch (error) {
      return DataFailed(error);
    }
  }
}
