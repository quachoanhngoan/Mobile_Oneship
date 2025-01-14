import 'package:equatable/equatable.dart';

class EditProfileState extends Equatable {
  final bool isContinueStep;
  final bool isEnableContinue;
  final bool isLoading;
  final String? titleFailedDialog;
  final String? emailResponseSuccess;
  final String? phoneResponseSuccess;

  const EditProfileState(
      {this.isContinueStep = false,
      this.isLoading = false,
      this.titleFailedDialog,
      this.isEnableContinue = false,
      this.emailResponseSuccess,
      this.phoneResponseSuccess});

  EditProfileState copyWith({
    bool? isContinueStep,
    bool? isLoading,
    String? titleFailedDialog,
    bool? isEnableContinue,
    String? emailResponseSuccess,
    String? phoneResponseSuccess,
  }) {
    return EditProfileState(
      isContinueStep: isContinueStep ?? false,
      isLoading: isLoading ?? false,
      titleFailedDialog: titleFailedDialog,
      isEnableContinue: isEnableContinue ?? this.isEnableContinue,
      emailResponseSuccess: emailResponseSuccess ?? this.emailResponseSuccess,
      phoneResponseSuccess: phoneResponseSuccess ?? this.phoneResponseSuccess,
    );
  }

  @override
  List<Object?> get props => [
        isContinueStep,
        isLoading,
        titleFailedDialog,
        isEnableContinue,
        emailResponseSuccess,
        phoneResponseSuccess,
      ];
}
