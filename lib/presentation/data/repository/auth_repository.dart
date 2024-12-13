import 'package:oneship_merchant_app/presentation/data/dto/request_login.dart';
import 'package:oneship_merchant_app/presentation/data/utils.dart';

mixin AuthUrl {
  static const String login = '/api/v1/merchant/auth/login';
  static const String loginBySms = '/api/v1/merchant/auth/login/sms';
  static const String logout = '/api/v1/auth/logout';
  static const String profile = '/api/v1/auth/profile';
  static const String changePassword = '/api/auth/change-password';
  static const String register = '/api/v1/registrations';
  static const String baseAuth = '/api/auth';
  static const String getVehicleInUse = '/api/v1/vehicles/in-use';
  static const String getVehicleType = '/api/v1/vehicles';
}

class AuthRepository {
  Future<LoginResponse> login(
      String provinceId, RequestLoginDto request) async {}
}

class AuthImpl implements AuthRepository {
  final DioUtil _clientDio;
  AuthImpl(
    this._clientDio,
  );

  @override
  Future<LoginResponse> login(
      String provinceId, RequestLoginDto request) async {
    final httpResponse = await _clientDio.post(
      AuthUrl.login,
      data: request.toJson(),
      isShowError: false,
      isAuth: false,
    );

    final data = LoginModel.fromJson(httpResponse.data ?? {});
  }
}
