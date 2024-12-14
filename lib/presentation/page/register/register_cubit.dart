import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/extensions/string_extention.dart';
import 'package:oneship_merchant_app/presentation/page/register/register_state.dart';

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
    if (pass.isNotNullOrEmpty && repass.isNotNullOrEmpty && pass == repass) {
      emit(state.copyWith(isEnableContinue: true));
    } else {
      emit(state.copyWith(isEnableContinue: false));
    }
  }
}
