import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/core/resources/data_state.dart';
import 'package:oneship_merchant_app/extensions/string_extention.dart';
import 'package:oneship_merchant_app/presentation/data/validations/user_validation.dart';
import 'package:oneship_merchant_app/presentation/page/register/register_state.dart';

import '../../../core/constant/error_strings.dart';
import '../../../core/repositories/auth/auth_repository.dart';
import '../../../domain/requests/register_phone/phone_register_request.dart';
import '../../../injector.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  final String _tag = "RegisterCubit";

  String? smsCode;
  bool? isTimeout;

  changePage(int index) {
    var title = "";
    switch (index) {
      case 1:
        title = "Xác thực OTP";
        break;
      case 2:
        title = "Tạo mật khẩu mới";
        break;
      default:
        title = "Nhập SĐT/Email";
        break;
    }
    emit(state.copyWith(
        title: title, isEnableContinue: false, isContinueStep: false));
  }

  validateUserName(String? value) {
    emit(state.copyWith(isEnableContinue: value.isNotNullOrEmpty));
  }

  validateOtp(String? otp) {
    emit(state.copyWith(
        isEnableContinue: otp.isNotNullOrEmpty && otp!.length >= 6));
    if (otp != null && otp.length >= 6) {
      smsCode = otp;
    }
  }

  validatePass(String? pass, String? repass) {
    emit(state.copyWith(
        showHintTextPass: !pass.isNotNullOrEmpty,
        showHintTextRePass: !repass.isNotNullOrEmpty));

    final userValidate = injector.get<UserValidate>();
    String? errorPass;
    String? errorRePass;

    if (pass.isNotNullOrEmpty) {
      errorPass = userValidate.passValid(pass!);
    } else {
      errorPass = null;
    }

    if (repass.isNotNullOrEmpty) {
      errorRePass = userValidate.passValid(repass!);
    } else {
      errorRePass = null;
    }

    if (pass.isNotNullOrEmpty &&
        repass.isNotNullOrEmpty &&
        errorPass == null &&
        errorRePass == null) {
      if (pass == repass) {
        emit(state.copyWith(
            isEnableContinue: true, errorPass: null, errorRepass: null));
      } else {
        emit(state.copyWith(
            isEnableContinue: false,
            errorRepass: AppErrorString.kRePassIsNotCorrect));
      }
    } else {
      emit(state.copyWith(
          isEnableContinue: false,
          errorPass: errorPass,
          errorRepass: errorRePass));
    }
  }

  submitPhoneOrEmail(String value) {
    emit(state.copyWith(isLoading: true, isFailedPhone: false));
    final isPhone = injector.get<UserValidate>().phoneValid(value);
    if (isPhone) {
      _sentPhoneToFirebase(value);
    } else {
      final isEmail = injector.get<UserValidate>().emailValid(value);
      if (isEmail) {
        log("check email");
      } else {
        emit(state.copyWith(isFailedPhone: true));
      }
    }
  }

  _sentPhoneToFirebase(String phone) async {
    isTimeout = false;
    final phoneConvert = _phoneToInternational(phone);
    await injector.get<AuthRepositoy>().loginFirebaseWithPhone(phoneConvert,
        success: (verificationId, resendToken) {
      emit(state.copyWith(isContinueStep: true));
    }, failed: (e) {
      emit(state.copyWith(isFailedPhone: true));
    }, timeout: (verificationId) {
      isTimeout = true;
    });
  }

  sentOtpToFirebase() async {
    emit(state.copyWith(isLoading: true));
    final idToken =
        await injector.get<AuthRepositoy>().loginFirebaseWithOTP(smsCode);
    if (idToken != null && isTimeout != true) {
      emit(state.copyWith(isContinueStep: true));
    } else {
      emit(state.copyWith(isFailedOTP: true));
    }
  }

  String _phoneToInternational(String phone) {
    if (phone.startsWith('0')) {
      return phone.replaceFirst('0', '+84');
    } else if (phone.startsWith('+84')) {
      return phone;
    }
    return phone;
  }

  createPasswordWithPhone(String password) async {
    emit(state.copyWith(isLoading: true));
    final request = RegisterPhoneRequest(
      password: password,
    );
    final response =
        await injector.get<AuthRepositoy>().createUserWithPhone(request);
    if (response is DataSuccess) {
      log("create account success: $response", name: _tag);
      emit(state.copyWith(isContinueStep: true));
    } else {
      log("create account failed: ${response.data?.message}", name: _tag);
      if (response.error?.message == AppErrorString.kPhoneConflictType) {
        emit(state.copyWith(registerFailed: AppErrorString.kPhoneConflict));
      } else {
        emit(state.copyWith(registerFailed: AppErrorString.kServerError));
      }
    }
  }
}
