part of 'auth_cubit.dart';

class AuthState {
  final String email;
  final String password;
  final bool isHidePassword;
  final bool isErrorOnOff;
  final bool isLoginWithPhone;
  final EState loadingState;
  AuthState({
    this.email = "",
    this.password = "",
    this.isHidePassword = true,
    this.isErrorOnOff = false,
    this.isLoginWithPhone = false,
    this.loadingState = EState.initial,
  });

  AuthState copyWith({
    String? email,
    String? password,
    bool? isHidePassword,
    bool? isErrorOnOff,
    bool? isLoginWithPhone,
    EState? loadingState,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      isHidePassword: isHidePassword ?? this.isHidePassword,
      isErrorOnOff: isErrorOnOff ?? this.isErrorOnOff,
      isLoginWithPhone: isLoginWithPhone ?? this.isLoginWithPhone,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
