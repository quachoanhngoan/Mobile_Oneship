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
  final String? titleFailedDialog;
  final bool? isPhone;
  final String? errorUserName;

  const RegisterState({
    this.title = 'Nhập SĐT/Email',
    this.isEnableContinue,
    this.showHintTextPass = true,
    this.showHintTextRePass = true,
    this.errorPass,
    this.errorRepass,
    this.isContinueStep = false,
    this.isLoading,
    this.titleFailedDialog,
    this.isPhone,
    this.errorUserName,
  });

  RegisterState copyWith({
    String? title,
    bool? isEnableContinue,
    bool? showHintTextPass,
    bool? showHintTextRePass,
    String? errorPass,
    String? errorRepass,
    bool? isContinueStep,
    bool? isLoading,
    String? titleFailedDialog,
    bool? isPhone,
    String? errorUserName,
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
      titleFailedDialog: titleFailedDialog,
      isPhone: isPhone ?? this.isPhone,
      errorUserName: errorUserName,
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
        titleFailedDialog,
        isPhone,
        errorUserName,
      ];
}
