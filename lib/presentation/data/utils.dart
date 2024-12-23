import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as GetXXX;
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/extensions/string_extention.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/service/pref_manager.dart';

import '../../core/resources/env_manager.dart';

class DioUtil {
  DioUtil(
    this._dio,
    this._pref,
  ) {
    _setUpInterceptors();
  }

  final Dio _dio;
  final PrefManager _pref;

  int _retryCount = 0;
  final List<Duration> _retryDelays = const [
    Duration(seconds: 1),
    Duration(seconds: 3),
    // Duration(seconds: 3)
  ];
  final Duration _timeoutDuration = const Duration(seconds: 20);

  Future<void> _setUpInterceptors() async {
    // Base options
    _dio.options.baseUrl = EnvManager.shared.api;
    _dio.options.connectTimeout = _timeoutDuration;
    _dio.options.receiveTimeout = _timeoutDuration;
    _dio.options.sendTimeout = _timeoutDuration;
    _dio.options.headers = {'Content-Type': 'application/json'};
  }

  //checkToken
  Future<bool> refreshToken() async {
    log('refreshToken');
    try {
      final refreshToken = _pref.refreshToken;

      if (refreshToken != null && refreshToken.isEmpty) {
        await GetXXX.Get.offAllNamed(AppRoutes.onBoardingPage);
        throw authException;
      }
      final response = await _dio.post(
        "/api/v1/merchant/auth/refresh-token",
        data: {
          "refreshToken": _pref.refreshToken,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${_pref.token}',
          },
        ),
      );

      if (response.data != null) {
        _pref.token = response.data['accessToken'];
        _pref.refreshToken = response.data['refreshToken'];
        return true;
      } else {
        await GetXXX.Get.offAllNamed(AppRoutes.onBoardingPage);

        throw authException;
      }
    } on DioException catch (e) {
      log('refreshToken error$e');
      await GetXXX.Get.offAllNamed(AppRoutes.onBoardingPage);
      rethrow;
    }
  }

  Future<Response<dynamic>> _execute(
    Future<Response<dynamic>> Function() request, {
    // bool isShowError = false,
    bool isRetry = false,
    bool isAuth = true,
    bool isTranformData = false,
  }) async {
    try {
      final response = await request();

      if (isTranformData) {
        if (response.data == null) {
          throw DioException(
              requestOptions: response.requestOptions,
              response: response,
              message: 'Không có dữ liệu trả về');
        }
        final data = BaseResponse.fromJson(response.data ?? {});

        // if (data.statusCode == 200) {
        //   throw DioException(
        //       requestOptions: response.requestOptions,
        //       response: response,
        //       message: (data.message != null && data.message!.isNotEmpty)
        //           ? data.message
        //           : 'Đã có lỗi xảy ra, vui lòng thử lại');
        // }
        if (data.statusCode == 200 && data.data == null) {
          throw DioException(
              requestOptions: response.requestOptions,
              response: response,
              message: data.message.isNullOrEmptyOrWhiteSpace()
                  ? 'Không có dữ liệu trả về'
                  : data.message);
        }

        return Response<dynamic>(
          data: data.data,
          requestOptions: response.requestOptions,
          statusCode: response.statusCode,
          statusMessage: response.statusMessage,
          headers: response.headers,
          isRedirect: response.isRedirect,
          redirects: response.redirects,
          extra: response.extra,
        );
      }

      return response;
    } on DioException catch (e) {
      if (prefManager.token != null &&
          (e.response?.statusCode == 401 || e.response?.statusCode == 403)) {
        final checked = await refreshToken();
        if (checked) {
          return await _execute(
            request,
            isAuth: isAuth,
            isRetry: isRetry,
            isTranformData: isTranformData,
          );
        } else {
          throw DioException(
            requestOptions: e.requestOptions,
            response: e.response,
          );
        }
      }
      if (isRetry) {
        if (e.response?.statusCode == 401) {
          _retryCount = 0;
          throw DioException(
            requestOptions: e.requestOptions,
            response: e.response,
          );
        }

        if (_retryCount < _retryDelays.length) {
          // if (_isRetryableError(e)) {
          await Future.delayed(_retryDelays[_retryCount]);
          _retryCount++;
          return _execute(
            request,
            isRetry: isRetry,
            // isShowError: isShowError,
            isTranformData: isTranformData,
          );
          // }
        }
        _retryCount = 0;
      }

      // if (isShowError) {
      //   _handleErrorDialog(e);
      // }
      throw DioException(
        requestOptions: e.requestOptions,
        response: e.response,
        message: handleErrorTranslate(e),
      );
    }
  }

  // void _handleErrorDialog(DioException e) {
  //   final customMessages = {
  //     DioExceptionType.connectionTimeout: 'Lỗi kết nối, vui lòng thử lại',
  //     DioExceptionType.sendTimeout: 'Lỗi gửi dữ liệu, vui lòng thử lại',
  //     DioExceptionType.receiveTimeout: 'Lỗi nhận dữ liệu, vui lòng thử lại',
  //     DioExceptionType.cancel: 'Kết nối bị hủy, vui lòng thử lại',
  //     DioExceptionType.connectionError: 'Lỗi kết nối mạng, vui lòng thử lại',
  //   };
  //   //check if type in customMessages
  //   if (customMessages.containsKey(e.type)) {
  //     return;
  //   }

  //   //TODO show dialog error
  // }

  Future<Response<dynamic>> _retryableRequest(
    Future<Response<dynamic>> Function() request, {
    bool isRetry = false,
    bool isShowError = false,
    bool isTranformData = false,
  }) async {
    return _execute(
      request,
      isRetry: isRetry,
      // isShowError: isShowError,
      isTranformData: isTranformData,
    );
  }

  Future<Response<dynamic>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String? path,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    bool isRetry = false,
    bool isShowError = false,
    bool isTranformData = true,
    bool isAuth = true,
    bool isProvinceHeader = true,
  }) async {
    if (isProvinceHeader) {
      headers = {
        ...?headers,
        // provinceHeader: _pref.provinceId,
      };
    }

    if (isAuth) {
      final apiToken = _pref.token;
      if (apiToken == null) {
        throw authException;
      }

      queryParameters = {
        ...?queryParameters,
      };
      headers = {
        ...?headers,
        "Authorization": "Bearer $apiToken",
      };
    }

    return _retryableRequest(
      () => _dio.get(
        url,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: Options(
          headers: {
            ...?headers,
          },
        ),
      ),
      isRetry: isRetry,
      isShowError: isShowError,
      isTranformData: isTranformData,
    );
  }

  // Add similar methods for post, put, delete, patch, download, request, fetch...

  //post
  Future<Response<dynamic>> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String path = '',
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool isRetry = false,
    // bool isShowError = false,
    bool isTranformData = true,
    bool isAuth = true,
    bool isProvinceHeader = true,
  }) async {
    if (isProvinceHeader) {
      headers = {
        ...?headers,
      };
    }
    if (isAuth) {
      final apiToken = _pref.token;
      if (apiToken == null) {
        throw authException;
      }

      queryParameters = {
        ...?queryParameters,
        "Authorization": "Bearer $apiToken",
      };
    }

    return _retryableRequest(
      () => _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        options: Options(
          headers: {
            ...?headers,
          },
        ),
      ),
      isRetry: isRetry,
      // isShowError: isShowError,
      isTranformData: isTranformData,
    );
  }

  //delete
  Future<Response<dynamic>> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String path = '',
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool isRetry = false,
    bool isShowError = false,
    bool isTranformData = true,
    bool isAuth = true,
    bool isProvinceHeader = true,
  }) async {
    if (isProvinceHeader) {
      headers = {
        ...?headers,
      };
    }
    if (isAuth) {
      final apiToken = _pref.token;
      if (apiToken == null) {
        throw authException;
      }

      queryParameters = {
        ...?queryParameters,
        "Authorization": "Bearer $apiToken",
      };
    }

    return _retryableRequest(
      () => _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: Options(
          headers: {
            ...?headers,
          },
        ),
      ),
      isRetry: isRetry,
      isShowError: isShowError,
      isTranformData: isTranformData,
    );
  }

  //put
  Future<Response<dynamic>> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String path = '',
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool isRetry = false,
    bool isShowError = false,
    bool isTranformData = true,
    bool isAuth = true,
    bool isProvinceHeader = true,
  }) async {
    if (isProvinceHeader) {
      headers = {
        ...?headers,
      };
    }
    if (isAuth) {
      final apiToken = _pref.token;
      if (apiToken == null) {
        throw authException;
      }

      queryParameters = {
        ...?queryParameters,
        "Authorization": "Bearer $apiToken",
      };
    }

    return _retryableRequest(
      () => _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        options: Options(
          headers: {
            ...?headers,
          },
        ),
      ),
      isRetry: isRetry,
      isShowError: isShowError,
      isTranformData: isTranformData,
    );
  }

  //put
  Future<Response<dynamic>> patch(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String path = '',
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool isRetry = false,
    bool isShowError = false,
    bool isTranformData = true,
    bool isAuth = true,
    bool isProvinceHeader = true,
  }) async {
    if (isProvinceHeader) {
      headers = {
        ...?headers,
      };
    }
    if (isAuth) {
      final apiToken = _pref.token;
      if (apiToken == null) {
        // DialogService.instance.showDialogFailure(
        //     content: 'Phiên đăng nhập đã hết hạn, vui lòng đăng nhập lại',
        //     textConfirm: 'Đóng',
        //     confirm: () => AppUtilities.instance.logoutAndDisposeBloc());
        return Future.error(authException);
      }

      queryParameters = {
        ...?queryParameters,
        "Authorization": "Bearer $apiToken",
      };
    }

    return _retryableRequest(
      () => _dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        options: Options(
          headers: {
            ...?headers,
          },
        ),
      ),
      isRetry: isRetry,
      isShowError: isShowError,
      isTranformData: isTranformData,
    );
  }
  //postMultipart

  Future<Response<dynamic>> postMultipart(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool isRetry = false,
    bool isShowError = false,
    bool isTranformData = false,
    bool isAuth = true,
    bool isProvinceHeader = true,
  }) async {
    if (isProvinceHeader) {
      headers = {
        ...?headers,
      };
    }

    if (isAuth) {
      final apiToken = _pref.token;
      if (apiToken == null) {
        // DialogService.instance.showDialogFailure(
        //     content: 'Phiên đăng nhập đã hết hạn, vui lòng đăng nhập lại',
        //     textConfirm: 'Đóng',
        //     confirm: () => AppUtilities.instance.logoutAndDisposeBloc());
        return Future.error(authException);
      }

      queryParameters = {
        ...?queryParameters,
        // token: apiToken,
        "Authorization": "Bearer $apiToken",
      };
    }

    return _retryableRequest(
      () => _dio.fetch(
        RequestOptions(
          method: "POST",
          baseUrl: url,
          cancelToken: cancelToken,
          data: data,
          queryParameters: queryParameters,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
          headers: {
            ...?headers,
          },
        ),
      ),
      isRetry: isRetry,
      isShowError: isShowError,
      isTranformData: isTranformData,
    );
  }

  String? handleErrorTranslate(DioException error) {
    try {
      final data = BaseResponse.fromJson(error.response?.data ?? {});
      final customMessages = {
        DioExceptionType.connectionTimeout: 'Lỗi kết nối, vui lòng thử lại',
        DioExceptionType.sendTimeout: 'Lỗi gửi dữ liệu, vui lòng thử lại',
        DioExceptionType.receiveTimeout: 'Lỗi nhận dữ liệu, vui lòng thử lại',
        DioExceptionType.cancel: 'Kết nối bị hủy, vui lòng thử lại',
        DioExceptionType.connectionError: 'Lỗi kết nối mạng, vui lòng thử lại',
      };
      return data.message.isNullOrEmptyOrWhiteSpace()
          ? customMessages[error.type] ?? 'Đã có lỗi xảy ra, vui lòng thử lại'
          : data.message;
    } catch (e) {
      return 'Đã có lỗi xảy ra, vui lòng thử lại';
    }
  }
}

class BaseResponse {
  BaseResponse({this.statusCode, this.message, this.data});

  final int? statusCode;
  final String? message;
  final dynamic data;

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
        statusCode: json['statusCode'],
        message: json['message'],
        data: json['data'],
      );

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'message': message,
        'data': data,
      };
}

DioException authException = DioException(
  requestOptions: RequestOptions(
    path: '',
    baseUrl: '',
    queryParameters: {},
    headers: {},
  ),
  response: Response<dynamic>(
    data: {},
    requestOptions: RequestOptions(
      path: '',
      baseUrl: '',
      queryParameters: {},
      headers: {},
    ),
    statusCode: 401,
    statusMessage: 'Phiên đăng nhập đã hết hạn, vui lòng đăng nhập lại',
    headers: Headers.fromMap({}),
    isRedirect: false,
    redirects: [],
    extra: {},
  ),
  message: 'Phiên đăng nhập đã hết hạn, vui lòng đăng nhập lại',
);
