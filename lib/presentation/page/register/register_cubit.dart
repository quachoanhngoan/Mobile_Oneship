import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/core/resources/data_state.dart';
import 'package:oneship_merchant_app/domain/requests/register_email/email_password_request.dart';
import 'package:oneship_merchant_app/domain/requests/register_email/email_register_request.dart';
import 'package:oneship_merchant_app/extensions/string_extention.dart';
import 'package:oneship_merchant_app/presentation/data/model/user/user_model.dart';
import 'package:oneship_merchant_app/presentation/data/validations/user_validation.dart';
import 'package:oneship_merchant_app/presentation/page/register/register_state.dart';

import '../../../core/constant/error_strings.dart';
import '../../../core/repositories/auth/auth_repository.dart';
import '../../../domain/requests/register_email/otp_request.dart';
import '../../../domain/requests/register_phone/phone_register_request.dart';
import '../../../injector.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  final String _tag = "RegisterCubit";

  String? smsCode;
  bool? isTimeout;

  void changePage(int index) {
    var title = "";
    switch (index) {
      case 1:
        title = "Nhập mã xác thực OTP";
        break;
      case 2:
        title = "Cài đặt mật khẩu";
        break;
      default:
        title = "Nhập SĐT/Email";
        break;
    }
    emit(state.copyWith(
        title: title,
        isEnableContinue: false,
        isContinueStep: false,
        showHintTextPass: true,
        showHintTextRePass: true));
  }

  void validateUserName(String? value) {
    emit(state.copyWith(isEnableContinue: value.isNotNullOrEmpty));
  }

  void validateUserNameChangePass(UserM userData, String? value) {
    if (value == userData.email || value == userData.phone) {
      emit(state.copyWith(errorUserName: null, isEnableContinue: true));
    } else {
      emit(state.copyWith(
          errorUserName: "SĐT hoặc email không đúng", isEnableContinue: false));
    }
  }

  void timeOutOtp() {
    emit(state.copyWith(isEnableContinue: false));
  }

  void validateOtp(String? otp) {
    emit(state.copyWith(
        isEnableContinue: otp.isNotNullOrEmpty && otp!.length >= 6));
    if (otp != null && otp.length >= 6) {
      smsCode = otp;
    }
  }

  void validatePass(String? pass, String? repass) {
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

    if (pass.isNotNullOrEmpty && repass.isNotNullOrEmpty && errorPass == null) {
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

  void submitPhoneOrEmail(String value,
      {required bool isReSent, required bool isRegister}) {
    if (!isReSent) {
      emit(state.copyWith(isLoading: true));
    }
    final isPhone = injector.get<UserValidate>().phoneValid(value);
    if (isPhone) {
      _sentPhoneToFirebase(value, isResent: isReSent);
    } else {
      final isEmail = injector.get<UserValidate>().emailValid(value);
      if (isEmail) {
        if (isRegister) {
          _registerEmail(value, isResent: isReSent);
        } else {
          _forgotPassWithEmail(value, isResent: isReSent);
        }
      } else {
        emit(state.copyWith(titleFailedDialog: AppErrorString.kPhoneInvalid));
      }
    }
  }

  Future _forgotPassWithEmail(String email, {required bool isResent}) async {
    final request = RegisterEmailRequest(email: email);
    final response =
        await injector.get<AuthRepositoy>().getOTPWithForgotEmail(request);

    if (response is DataSuccess) {
      emit(state.copyWith(isContinueStep: true, isPhone: false));
    } else {
      if (response.error?.response?.data['message'] ==
          AppErrorString.kNotFound) {
        emit(state.copyWith(titleFailedDialog: AppErrorString.kEmailNotFound));
      } else {
        emit(state.copyWith(titleFailedDialog: AppErrorString.kServerError));
      }
    }
  }

  Future _registerEmail(String email, {required bool isResent}) async {
    final request = RegisterEmailRequest(email: email);
    final response = await injector.get<AuthRepositoy>().registerEmail(request);
    if (response is DataSuccess) {
      if (!isResent) {
        emit(state.copyWith(isContinueStep: true, isPhone: false));
      }
    } else {
      if (response.error?.response?.data['message'] ==
          AppErrorString.kEmailConflictType) {
        emit(state.copyWith(titleFailedDialog: AppErrorString.kEmailConflict));
      } else {
        emit(state.copyWith(titleFailedDialog: AppErrorString.kServerError));
      }
    }
  }

  Future _sentPhoneToFirebase(String phone, {required bool isResent}) async {
    isTimeout = false;
    final phoneConvert = _phoneToInternational(phone);
    await injector.get<AuthRepositoy>().loginFirebaseWithPhone(phoneConvert,
        success: (verificationId, resendToken) {
      if (!isResent) {
        emit(state.copyWith(isContinueStep: true, isPhone: true));
      }
    }, failed: (e) {
      emit(state.copyWith(titleFailedDialog: AppErrorString.kPhoneInvalid));
    }, timeout: (verificationId) {
      isTimeout = true;
    });
  }

  Future sentOtp({String? email}) async {
    emit(state.copyWith(isLoading: true));
    if (state.isPhone == true) {
      final idToken =
          await injector.get<AuthRepositoy>().sentOtpToFirebase(smsCode);
      if (idToken != null && isTimeout != true) {
        emit(state.copyWith(isContinueStep: true));
      } else {
        emit(state.copyWith(titleFailedDialog: AppErrorString.kOTPInvalid));
      }
    } else {
      if (email != null) {
        final request = OtpRequest(otp: smsCode, email: email);
        final otpResponse =
            await injector.get<AuthRepositoy>().sentOtpWithAPI(request);
        if (otpResponse is DataSuccess) {
          emit(state.copyWith(isContinueStep: true));
        } else {
          emit(state.copyWith(titleFailedDialog: AppErrorString.kOTPInvalid));
        }
      }
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

  Future resetPasswordWithPhoneOrEmail(String password, {String? email}) async {
    emit(state.copyWith(isLoading: true));
    if (state.isPhone == true) {
      final response = await injector
          .get<AuthRepositoy>()
          .createForgotPassWithPhone(password);

      if (response is DataSuccess) {
        log("reset pass success: $response", name: _tag);
        emit(state.copyWith(
            isContinueStep: true,
            showHintTextPass: true,
            showHintTextRePass: true));
      } else {
        log("reset pass failed: ${response.error?.response?.data['message']}",
            name: _tag);
        if (response.error?.response?.data['message'] ==
            AppErrorString.kUnauthorized) {
          emit(state.copyWith(
              titleFailedDialog: AppErrorString.kPhoneNotRegister));
        } else {
          emit(state.copyWith(titleFailedDialog: AppErrorString.kServerError));
        }
      }
    } else {
      if (email != null) {
        final request = PasswordEmailRequest(
            email: email, password: password, otp: smsCode);
        final response = await injector
            .get<AuthRepositoy>()
            .createForgotPassWithEmail(request);
        if (response is DataSuccess) {
          log("reset pass success: $response", name: _tag);
          emit(state.copyWith(
              isContinueStep: true,
              showHintTextPass: true,
              showHintTextRePass: true));
        } else {
          log("reset account failed: ${response.data?.message}", name: _tag);
          emit(state.copyWith(titleFailedDialog: AppErrorString.kServerError));
        }
      }
    }
  }

  Future createPasswordWithPhoneOrEmail(String password,
      {String? email}) async {
    emit(state.copyWith(isLoading: true));
    if (state.isPhone == true) {
      final request = RegisterPhoneRequest(
        password: password,
      );
      final response =
          await injector.get<AuthRepositoy>().createUserWithPhone(request);
      if (response is DataSuccess) {
        log("create account success: $response", name: _tag);
        emit(state.copyWith(
            isContinueStep: true,
            showHintTextPass: true,
            showHintTextRePass: true));
      } else {
        log("create account failed: ${response.data?.message}", name: _tag);
        if (response.error?.response?.data['message'] ==
            AppErrorString.kPhoneConflictType) {
          emit(
              state.copyWith(titleFailedDialog: AppErrorString.kPhoneConflict));
        } else {
          emit(state.copyWith(titleFailedDialog: AppErrorString.kServerError));
        }
      }
    } else {
      if (email != null) {
        final request = PasswordEmailRequest(
            email: email, password: password, otp: smsCode);
        final response =
            await injector.get<AuthRepositoy>().createUserWithEmail(request);
        if (response is DataSuccess) {
          log("create account success: $response", name: _tag);
          emit(state.copyWith(
              isContinueStep: true,
              showHintTextPass: true,
              showHintTextRePass: true));
        } else {
          log("create account failed: ${response.data?.message}", name: _tag);
          emit(state.copyWith(titleFailedDialog: AppErrorString.kServerError));
        }
      }
    }
  }
}
