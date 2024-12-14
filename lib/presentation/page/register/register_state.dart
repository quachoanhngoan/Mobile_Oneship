import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final String? title;
  final bool? isEnableContinue;
  final bool? showHintTextPass;
  final bool? showHintTextRePass;
  final String? errorPass;
  final String? errorRepass;

  const RegisterState(
      {this.title = 'Xác thực OTP',
      this.isEnableContinue,
      this.showHintTextPass = true,
      this.showHintTextRePass = true,
      this.errorPass,
      this.errorRepass});

  RegisterState copyWith(
      {String? title,
      bool? isEnableContinue,
      bool? showHintTextPass,
      bool? showHintTextRePass,
      String? errorPass,
      String? errorRepass}) {
    return RegisterState(
        title: title ?? this.title,
        isEnableContinue: isEnableContinue ?? this.isEnableContinue,
        showHintTextPass: showHintTextPass ?? this.showHintTextPass,
        showHintTextRePass: showHintTextRePass ?? this.showHintTextRePass,
        errorPass: errorPass,
        errorRepass: errorRepass);
  }

  @override
  List<Object?> get props => [
        title,
        isEnableContinue,
        showHintTextPass,
        showHintTextRePass,
        errorPass,
        errorRepass
      ];
}
