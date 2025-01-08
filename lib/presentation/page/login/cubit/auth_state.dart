part of 'auth_cubit.dart';

class AuthState {
  final String email;
  final String password;
  final bool isHidePassword;
  final bool isErrorOnOff;
  final bool isLoginWithPhone;
  final EState loadingState;
  final EState getSmsState;
  final EState updateProfileState;
  final UserM? userData;
  final int timeCount;

  AuthState({
    this.email = "",
    this.password = "",
    this.isHidePassword = true,
    this.isErrorOnOff = false,
    this.isLoginWithPhone = false,
    this.loadingState = EState.initial,
    this.getSmsState = EState.initial,
    this.updateProfileState = EState.initial,
    this.userData,
    this.timeCount = 60,
  });

  AuthState copyWith({
    String? email,
    String? password,
    bool? isHidePassword,
    bool? isErrorOnOff,
    bool? isLoginWithPhone,
    EState? loadingState,
    EState? getSmsState,
    UserM? userData,
    int? timeCount,
    EState? updateProfileState,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      isHidePassword: isHidePassword ?? this.isHidePassword,
      isErrorOnOff: isErrorOnOff ?? this.isErrorOnOff,
      isLoginWithPhone: isLoginWithPhone ?? this.isLoginWithPhone,
      loadingState: loadingState ?? this.loadingState,
      getSmsState: getSmsState ?? this.getSmsState,
      userData: userData ?? this.userData,
      timeCount: timeCount ?? this.timeCount,
      updateProfileState: updateProfileState ?? this.updateProfileState,
    );
  }
}
