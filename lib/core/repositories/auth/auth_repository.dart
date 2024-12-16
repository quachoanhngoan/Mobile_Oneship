import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:oneship_merchant_app/core/datasource/auth_api_service.dart';
import 'package:oneship_merchant_app/core/repositories/base/base_api_repository.dart';
import 'package:oneship_merchant_app/core/resources/data_state.dart';
import 'package:oneship_merchant_app/domain/requests/register_phone/phone_register_request.dart';
import 'package:oneship_merchant_app/domain/responses/response_domain.dart';

abstract class AuthRepositoy {
  init();

  Future loginFirebaseWithPhone(
    String phone, {
    Function(FirebaseAuthException)? failed,
    Function(String, int?)? success,
    Function(String)? timeout,
  });

  Future<String?> loginFirebaseWithOTP(String? smsCode);

  Future<DataState<ResponseDomain>> createUserWithPhone(
      RegisterPhoneRequest request);
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
  Future<String?> loginFirebaseWithOTP(String? smsCode) async {
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
}
