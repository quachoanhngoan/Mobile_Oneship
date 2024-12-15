import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/extensions/string_extention.dart';
import 'package:oneship_merchant_app/presentation/data/validations/user_validation.dart';
import 'package:oneship_merchant_app/presentation/page/register/register_state.dart';

import '../../../core/constant/error_strings.dart';
import '../../../core/repositories/auth_repository.dart';
import '../../../injector.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

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
    emit(state.copyWith(title: title, isEnableContinue: false));
  }

  validateUserName(String? value) {
    emit(state.copyWith(isEnableContinue: value.isNotNullOrEmpty));
  }

  validateOtp(String? otp) {
    emit(state.copyWith(
        isEnableContinue: otp.isNotNullOrEmpty && otp!.length >= 6));
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

  sentPhone(String phone) async {
    injector.get<AuthRepositoy>().loginWithPhone(phone);
  }
}
