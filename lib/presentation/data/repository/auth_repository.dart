import 'package:oneship_merchant_app/presentation/data/dto/request_login.dart';
import 'package:oneship_merchant_app/presentation/data/model/user/user_model.dart';
import 'package:oneship_merchant_app/presentation/data/utils.dart';

mixin AuthUrl {
  static const String login = '/api/v1/merchant/auth/login';
  static const String loginBySms = '/api/v1/merchant/auth/login/sms';
  static const String logout = '/api/v1/auth/logout';
  static const String refreshToken = '/api/v1/auth/refesh-token';
  static const String profile = '/api/v1/auth/profile';
  static const String changePassword = '/api/auth/change-password';
  static const String register = '/api/v1/registrations';
  static const String baseAuth = '/api/auth';
}

abstract class AuthRepository {
  Future<UserM?> login(RequestLoginDto request);
  Future<UserM?> loginSms(RequestLoginSms request);
  Future<UserM?> profile();
}

class AuthImpl implements AuthRepository {
  final DioUtil _clientDio;
  AuthImpl(
    this._clientDio,
  );

  @override
  Future<UserM?> login(RequestLoginDto request) async {
    final httpResponse = await _clientDio.post(
      AuthUrl.login,
      data: request.toJson(),
      // isShowError: false,
      isTranformData: true,
      isAuth: false,
    );

    return UserM.fromMap(httpResponse.data ?? {});
  }

  @override
  Future<UserM?> loginSms(RequestLoginSms request) async {
    final httpResponse = await _clientDio.post(
      AuthUrl.loginBySms,
      data: request.toJson(),
      // isShowError: false,
      isTranformData: true,
      isAuth: false,
    );

    return UserM.fromMap(httpResponse.data ?? {});
  }

  @override
  Future<UserM?> profile() async {
    final httpResponse = await _clientDio.get(AuthUrl.profile,
        // isShowError: false,
        isTranformData: true,
        isAuth: true);

    return UserM.fromMap(httpResponse.data ?? {});
  }
}
