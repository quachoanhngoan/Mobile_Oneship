import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final String? title;
  final bool? isEnableContinue;
  final bool? showHintTextPass;
  final bool? showHintTextRePass;

  const RegisterState(
      {this.title = 'Xác thực OTP',
      this.isEnableContinue,
      this.showHintTextPass = true,
      this.showHintTextRePass = true});

  RegisterState copyWith(
      {String? title,
      bool? isEnableContinue,
      bool? showHintTextPass,
      bool? showHintTextRePass}) {
    return RegisterState(
      title: title ?? this.title,
      isEnableContinue: isEnableContinue ?? this.isEnableContinue,
      showHintTextPass: showHintTextPass ?? this.showHintTextPass,
      showHintTextRePass: showHintTextRePass ?? this.showHintTextRePass,
    );
  }

  @override
  List<Object?> get props =>
      [title, isEnableContinue, showHintTextPass, showHintTextRePass];
}
