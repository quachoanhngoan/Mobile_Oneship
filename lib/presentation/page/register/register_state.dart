import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final String? title;
  final bool? isEnableContinue;
  final bool? showHintTextPass;
  final bool? showHintTextRePass;
  final String? errorPass;
  final String? errorRepass;
  final bool? isContinueStep;
  final bool? isLoading;
  final bool? isFailedPhone;
  final bool? isFailedOTP;
  final String? registerFailed;

  const RegisterState(
      {this.title = 'Xác thực OTP',
      this.isEnableContinue,
      this.showHintTextPass = true,
      this.showHintTextRePass = true,
      this.errorPass,
      this.errorRepass,
      this.isContinueStep = false,
      this.isLoading,
      this.isFailedPhone = false,
      this.isFailedOTP = false,
      this.registerFailed});

  RegisterState copyWith({
    String? title,
    bool? isEnableContinue,
    bool? showHintTextPass,
    bool? showHintTextRePass,
    String? errorPass,
    String? errorRepass,
    bool? isContinueStep,
    bool? isLoading,
    bool? isFailedPhone,
    bool? isFailedOTP,
    String? registerFailed,
  }) {
    return RegisterState(
      title: title ?? this.title,
      isEnableContinue: isEnableContinue ?? this.isEnableContinue,
      showHintTextPass: showHintTextPass ?? this.showHintTextPass,
      showHintTextRePass: showHintTextRePass ?? this.showHintTextRePass,
      errorPass: errorPass,
      errorRepass: errorRepass,
      isContinueStep: isContinueStep ?? this.isContinueStep,
      isLoading: isLoading,
      isFailedPhone: isFailedPhone,
      isFailedOTP: isFailedOTP,
      registerFailed: registerFailed,
    );
  }

  @override
  List<Object?> get props => [
        title,
        isEnableContinue,
        showHintTextPass,
        showHintTextRePass,
        errorPass,
        errorRepass,
        isContinueStep,
        isLoading,
        isFailedPhone,
        isFailedOTP,
        registerFailed
      ];
}
