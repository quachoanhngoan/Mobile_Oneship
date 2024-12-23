import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:oneship_merchant_app/core/datasource/auth_api_service.dart';
import 'package:oneship_merchant_app/core/repositories/base/base_api_repository.dart';
import 'package:oneship_merchant_app/core/resources/data_state.dart';
import 'package:oneship_merchant_app/domain/requests/register_email/email_password_request.dart';
import 'package:oneship_merchant_app/domain/requests/register_email/otp_request.dart';
import 'package:oneship_merchant_app/domain/requests/register_phone/phone_register_request.dart';
import 'package:oneship_merchant_app/domain/responses/response_domain.dart';

import '../../../domain/requests/register_email/email_register_request.dart';

abstract class AuthRepositoy {
  init();

  Future<DataState<ResponseDomain>> registerEmail(RegisterEmailRequest email);

  Future loginFirebaseWithPhone(
    String phone, {
    Function(FirebaseAuthException)? failed,
    Function(String, int?)? success,
    Function(String)? timeout,
  });

  Future<DataState<ResponseDomain>> sentOtpWithAPI(OtpRequest request);

  Future<String?> sentOtpToFirebase(String? smsCode);

  Future<DataState<ResponseDomain>> createUserWithPhone(
      RegisterPhoneRequest request);

  Future<DataState<ResponseDomain>> createUserWithEmail(
      PasswordEmailRequest request);

  Future<DataState<ResponseDomain>> getOTPWithForgotEmail(
      RegisterEmailRequest request);

  Future<DataState<ResponseDomain>> createForgotPassWithPhone(String password);

  Future<DataState<ResponseDomain>> createForgotPassWithEmail(
      PasswordEmailRequest request);
}

class AuthRepositoryImpl extends BaseApiRepository implements AuthRepositoy {
  final AuthApiService _authApiService;
  AuthRepositoryImpl(this._authApiService);

  final TAG = "AuthRepositoy";

  late final FirebaseAuth _auth;

  String? verificationId;
  String? idToken;
  String? firebaseFCMToken;

  @override
  init() async {
    _auth = FirebaseAuth.instance;
    await _fetchFcmToken();
  }

  Future<bool> _fetchFcmToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        log("FCM Token: $token", name: TAG);
        firebaseFCMToken = token;
      } else {
        log("Can't get FCM token", name: TAG);
      }
    } catch (e) {
      log("Get FCM token error: $e", name: TAG);
    }
    return true;
  }

  @override
  Future loginFirebaseWithPhone(
    String phone, {
    Function(FirebaseAuthException)? failed,
    Function(String, int?)? success,
    Function(String)? timeout,
  }) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (credential) async {
          log("verificationCompleted: $credential", name: TAG);
        },
        verificationFailed: (e) {
          if (failed != null) {
            failed(e);
          }
        },
        codeSent: (verifyId, resendToken) {
          log("Verification ID: $verifyId and $resendToken", name: TAG);
          if (success != null) {
            verificationId = verifyId;
            success(verifyId, resendToken);
          }
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (verifyId) {
          if (timeout != null) {
            timeout(verifyId);
          }
        });
  }

  @override
  Future<String?> sentOtpToFirebase(String? smsCode) async {
    try {
      if (verificationId != null && smsCode != null) {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId!, smsCode: smsCode);

        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        String? result = await userCredential.user?.getIdToken();
        log("sent otp success: $result", name: TAG);
        idToken = result;
        return result;
      }
    } catch (e) {
      log("check error send otp: $e", name: TAG);
    }
    return null;
  }

  @override
  Future<DataState<ResponseDomain>> createUserWithPhone(
      RegisterPhoneRequest request) async {
    final parseRequest =
        request.copyWith(idToken: idToken, deviceToken: firebaseFCMToken);
    return getStateOf<ResponseDomain>(request: () async {
      return await _authApiService.registerPhone(parseRequest);
    });
  }

  @override
  Future<DataState<ResponseDomain>> registerEmail(
      RegisterEmailRequest email) async {
    return getStateOf<ResponseDomain>(request: () async {
      return await _authApiService.registerEmail(email);
    });
  }

  @override
  Future<DataState<ResponseDomain>> sentOtpWithAPI(OtpRequest request) {
    return getStateOf<ResponseDomain>(request: () async {
      return await _authApiService.checkOtp(request);
    });
  }

  @override
  Future<DataState<ResponseDomain>> createUserWithEmail(
      PasswordEmailRequest request) {
    return getStateOf<ResponseDomain>(request: () async {
      return await _authApiService.createUserWithEmail(request);
    });
  }

  @override
  Future<DataState<ResponseDomain>> getOTPWithForgotEmail(
      RegisterEmailRequest request) {
    return getStateOf(request: () async {
      return await _authApiService.getOTPWithForgotEmail(request);
    });
  }

  @override
  Future<DataState<ResponseDomain>> createForgotPassWithEmail(
      PasswordEmailRequest request) {
    return getStateOf(request: () async {
      return await _authApiService.forgotPassWithEmail(request);
    });
  }

  @override
  Future<DataState<ResponseDomain>> createForgotPassWithPhone(String password) {
    return getStateOf(request: () async {
      return await _authApiService.forgotPassWithPhone(
          {"idToken": idToken ?? "", "password": password});
    });
  }
}
