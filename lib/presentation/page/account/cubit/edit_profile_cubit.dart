import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/core/constant/error_strings.dart';
import 'package:oneship_merchant_app/core/repositories/auth/auth_repository.dart';
import 'package:oneship_merchant_app/core/resources/data_state.dart';
import 'package:oneship_merchant_app/domain/requests/register_email/otp_request.dart';
import 'package:oneship_merchant_app/domain/responses/auth/update_email_res_domain.dart';
import 'package:oneship_merchant_app/extensions/string_extention.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/page/account/cubit/edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(const EditProfileState());

  String? smsCode;
  bool? isTimeout;

  void resetState() {
    smsCode = null;
    isTimeout = null;
    emit(state.copyWith(
        isLoading: false, isContinueStep: false, isEnableContinue: false));
  }

  void validateOtp(String? otp) {
    emit(state.copyWith(
        isEnableContinue: otp.isNotNullOrEmpty && otp!.length >= 6));
    if (otp != null && otp.length >= 6) {
      smsCode = otp;
    }
  }

  void timeOutOtp() {
    emit(state.copyWith(isEnableContinue: false));
  }

  Future sentOtp({String? email, bool isPhone = true}) async {
    emit(state.copyWith(isLoading: true));
    if (isPhone == true) {
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
        final otpResponse = await injector
            .get<AuthRepositoy>()
            .sentOtpWithEmailProfile(request);
        if (otpResponse is DataSuccess) {
          emit(state.copyWith(isContinueStep: true));
        } else {
          emit(state.copyWith(titleFailedDialog: AppErrorString.kOTPInvalid));
        }
      }
    }
  }

  Future submitEmailToGetOTP({bool isResent = false}) async {
    emit(state.copyWith(isLoading: true));
    final response =
        await injector.get<AuthRepositoy>().submitEmailGetOTPUpdatePhone();
    if (response.data?.statusCode == 200) {
      if (isResent) {
        // emit(state.copyWith(isEnableContinue: false));
      } else {
        emit(state.copyWith(isContinueStep: true));
      }
    }
  }

  void submitPhoneToGetOTP(String value,
      {required bool isReSent, required String phone}) async {
    if (!isReSent) {
      emit(state.copyWith(isLoading: true));
    }
    isTimeout = false;
    final phoneConvert = _phoneToInternational(phone);
    await injector.get<AuthRepositoy>().loginFirebaseWithPhone(phoneConvert,
        success: (verificationId, resendToken) {
      if (!isReSent) {
        emit(state.copyWith(isContinueStep: true));
      }
    }, failed: (e) {
      emit(state.copyWith(titleFailedDialog: AppErrorString.kPhoneInvalid));
    }, timeout: (verificationId) {
      isTimeout = true;
      // emit(state.copyWith(isLoading: false));
      // emit(state.copyWith(titleFailedDialog: AppErrorString.kTimeOutOtp));
    });
  }

  String _phoneToInternational(String phone) {
    if (phone.startsWith('0')) {
      return phone.replaceFirst('0', '+84');
    } else if (phone.startsWith('+84')) {
      return phone;
    }
    return phone;
  }

  Future sendEmailUpdate(String email) async {
    emit(state.copyWith(isLoading: true));
    final response =
        await injector.get<AuthRepositoy>().updateEmailProfile(email);
    if (response.data != null) {
      final parseData = UpdateEmailResDomain.fromJson(response.data!.data);
      emit(state.copyWith(
          emailResponseSuccess: parseData.email, isContinueStep: true));
    } else {
      emit(state.copyWith(titleFailedDialog: "Không thể đổi email"));
    }
  }

  Future sendPhoneUpdate(String phone) async {
    if (smsCode != null) {
      emit(state.copyWith(isLoading: true));
      final response = await injector
          .get<AuthRepositoy>()
          .updatePhoneProfile(phone, smsCode!);
      if (response.data != null) {
        emit(state.copyWith(phoneResponseSuccess: phone, isContinueStep: true));
      } else {
        emit(state.copyWith(titleFailedDialog: "Không thể đổi số điện thoại"));
      }
    }
  }
}
