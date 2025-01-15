import 'package:oneship_merchant_app/presentation/data/dto/request_login.dart';
import 'package:oneship_merchant_app/presentation/data/model/user/user_model.dart';
import 'package:oneship_merchant_app/presentation/data/utils.dart';

mixin AuthUrl {
  static const String login = '/api/v1/merchant/auth/login';
  static const String loginBySms = '/api/v1/merchant/auth/login/sms';
  static const String logout = '/api/v1/merchant/auth/logout';
  static const String refreshToken = '/api/v1/merchant/auth/refesh-token';
  static const String profile = '/api/v1/merchant/auth/profile';
  static const String changePassword = '/api/v1/merchant/auth/change-password';
  static const String register = '/api/v1/merchant/registrations';
  static const String baseAuth = '/api/merchant/auth';
}

abstract class AuthRepository {
  Future<UserM?> login(RequestLoginDto request);
  Future<UserM?> loginSms(RequestLoginSms request);
  Future<UserM?> profile();
  Future<bool> updateProfile(String? name, String? avatar);
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

  @override
  Future<bool> updateProfile(String? name, String? avatar) async {
    final avatarS = avatar == "" ? null : avatar;
    final httpResponse = await _clientDio.patch(AuthUrl.profile,
        data: {
          if (name != null) "name": name,
          if (avatar != null) "avatarId": avatarS,
        },
        // isShowError: false,
        isTranformData: true,
        isAuth: true);

    return httpResponse.statusCode == 200;
  }
}
