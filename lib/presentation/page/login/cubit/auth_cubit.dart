import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/app.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/core/execute/execute.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/data/dto/request_login.dart';
import 'package:oneship_merchant_app/presentation/data/model/user/user_model.dart';
import 'package:oneship_merchant_app/presentation/data/repository/auth_repository.dart';
import 'package:oneship_merchant_app/service/dialog.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;
  AuthCubit(this.repository) : super(AuthState(userData: prefManager.user));
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController otpController = TextEditingController();
  String _verificationId = "";
  Timer? _timer;

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    try {
      if (state.timeCount != 0 && state.timeCount != 60) {
        return;
      }
      setGetSmsState(EState.loading);
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-retrieve verification code
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) async {
          if (e.code == 'invalid-phone-number') {
            setGetSmsState(EState.failure);
            await dialogService.showAlertDialog(
              title: 'Lỗi',
              description: 'Số điện thoại không hợp lệ',
              buttonTitle: 'OK',
              onPressed: () {
                Get.back();
                Get.back();
              },
            );
          } else {
            setGetSmsState(EState.failure);

            dialogService.showAlertDialog(
              onPressed: () {
                Get.back();
                Get.back();
              },
              title: 'Lỗi',
              buttonTitle: 'OK',
              description: (e.message ?? 'Có lỗi xảy ra'),
            );
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          // Save the verification ID for future use
          _verificationId = verificationId;
          print('codeSent');
          countDownTime();
          setGetSmsState(EState.success);

          // Sign the user in with the credential
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-retrieve verification code
          _verificationId = verificationId;
        },
        timeout: const Duration(seconds: 60),
      );
      // setGetSmsState(EState.success);
    } catch (e) {
      setGetSmsState(EState.failure);

      dialogService.showAlertDialog(
          title: 'Lỗi',
          description: 'Có lỗi xảy ra',
          buttonTitle: 'OK',
          onPressed: () {
            Get.back();
            Get.back();
          });
    }
  }

  void verifyOTP(String valueSMS) {
    setLoginState(EState.loading);

    final otp = valueSMS.trim();
    if (_verificationId != "") {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId,
          smsCode: otp,
        );

        loginSMS(credential);
      } catch (e) {
        dialogService.showAlertDialog(
          title: 'Lỗi',
          description: 'Mã xác thực không hợp lệ, vui lòng kiểm tra lại',
          buttonTitle: 'OK',
          onPressed: () => Get.back(),
        );
        setLoginState(EState.failure);
        return;
      }
    }
  }

  loginSubmit(String phone, String password, bool isSavePassword) async {
    emit(state.copyWith(loadingState: EState.loading));
    if (phone.isEmpty || password.isEmpty) {
      emit(state.copyWith(
        loadingState: EState.failure,
      ));
      return;
    }

    // if (firebaseToken == null) {
    //   await getDeviceToken();
    //   if (firebaseToken == null) {
    //     setLoginState(EState.failure);

    //     dialogService.showAlertDialog(
    //       title: "Thông báo",
    //       description: "Bạn chưa cấp quyền cho ứng dụng, vui lòng thử lại",
    //       buttonTitle: 'OK',
    //       onPressed: () {
    //         Get.back();
    //       },
    //     );
    //     return;
    //   }
    // }
    final response = await execute(() => repository.login(RequestLoginDto(
          password: password,
          username: phone,
          deviceToken: firebaseToken ?? "test",
        )));
    response.when(success: (data) {
      if (data == null) {
        emit(state.copyWith(
          loadingState: EState.failure,
        ));
        return;
      }
      emit(state.copyWith(
        loadingState: EState.success,
        userData: data,
      ));
      prefManager.token = data.accessToken!;
      prefManager.refreshToken = data.refreshToken!;
      prefManager.user = data;

      if (isSavePassword) {
        prefManager.userName = phone;
        prefManager.password = password;
      } else {
        prefManager.userName = "";
        prefManager.password = "";
      }

      Get.offAllNamed(AppRoutes.store);
    }, failure: (error) {
      emit(state.copyWith(
        loadingState: EState.failure,
      ));
    });
  }

  setLoginState(EState value) {
    emit(state.copyWith(loadingState: value));
  }

  setGetSmsState(EState value) {
    emit(state.copyWith(getSmsState: value));
  }

  loginSMS(
    PhoneAuthCredential phoneAuthCredential,
    // String idToken,
  ) async {
    setLoginState(EState.loading);
    try {
      final result =
          await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);

      if (result.user?.getIdToken() != null) {
        final idToken = await result.user!.getIdToken();

        // if (firebaseToken == null) {
        //   await getDeviceToken();
        //   if (firebaseToken == null) {
        //     setLoginState(EState.failure);

        //     dialogService.showAlertDialog(
        //       title: "Thông báo",
        //       description: "Bạn chưa cấp quyền cho ứng dụng, vui lòng thử lại",
        //       buttonTitle: 'OK',
        //       onPressed: () {
        //         Get.back();
        //       },
        //     );
        //     return;
        //   }
        // }
        final response =
            await execute(() => repository.loginSms(RequestLoginSms(
                  idToken: idToken,
                  deviceToken: firebaseToken ?? "test",
                )));
        response.when(success: (data) {
          otpController.clear();

          if (data == null) {
            emit(state.copyWith(
              loadingState: EState.failure,
            ));
            return;
          }

          emit(state.copyWith(
            loadingState: EState.success,
            userData: data,
          ));
          _timer?.cancel();
          prefManager.token = data.accessToken!;
          prefManager.refreshToken = data.refreshToken!;
          prefManager.user = data;
          prefManager.userName = "";
          prefManager.password = "";

          Get.offAllNamed(AppRoutes.store);
        }, failure: (error) {
          emit(state.copyWith(
            loadingState: EState.failure,
          ));
        });
      } else {
        emit(state.copyWith(
          loadingState: EState.failure,
        ));

        dialogService.showAlertDialog(
            title: "Mã xác thực sai",
            description: "Vui lòng thử lại",
            buttonTitle: 'OK',
            onPressed: () {
              otpController.clear();
              Get.back();
            });
      }
    } catch (e) {
      emit(state.copyWith(
        loadingState: EState.failure,
      ));

      dialogService.showAlertDialog(
          title: "Mã xác thực sai",
          description: "Vui lòng thử lại",
          buttonTitle: 'OK',
          onPressed: () {
            otpController.clear();
            Get.back();
          });
    }
  }

  getProfile() async {
    final response = await execute(() => repository.profile());
    response.when(
        success: (data) {
          if (data == null) {
            return;
          }
          prefManager.user = data;
          emit(state.copyWith(userData: data));
        },
        failure: (error) {});
  }

  logout() {
    prefManager.logout();
    Get.offAllNamed(AppRoutes.onBoardingPage);
  }

  countDownTime() {
    setTimeCount(60);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.timeCount == 0) {
        _timer?.cancel();
      } else {
        setTimeCount(state.timeCount - 1);
      }
    });
  }

  resetTimer() {
    _timer?.cancel();
    setTimeCount(60);
  }

  setTimeCount(int value) {
    emit(state.copyWith(timeCount: value));
  }

  resetState() {
    emit(AuthState());
  }
}
