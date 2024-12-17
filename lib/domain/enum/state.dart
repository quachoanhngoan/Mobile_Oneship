import 'package:flutter_bloc/flutter_bloc.dart';

enum EState {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == EState.initial;
  bool get isLoading => this == EState.loading;
  bool get isSuccess => this == EState.success;
  bool get isFailure => this == EState.failure;
}

mixin BaseCubit<T> on Cubit<T> {
  void setLoading() {
    emit((state as dynamic).copyWith(status: EState.loading));
  }

  void setSuccess() {
    emit((state as dynamic).copyWith(status: EState.success));
  }

  void setFailure() {
    emit((state as dynamic).copyWith(status: EState.failure));
  }

  void catchFailure(dynamic failure) {
    emit((state as dynamic).copyWith(
      status: EState.failure,
    ));
  }

  void catchFailureAndShowError(dynamic failure) {
    emit((state as dynamic).copyWith(
      status: EState.failure,
    ));
  }

  void setInitial() {
    emit((state as dynamic).copyWith(status: EState.initial));
  }

  void setDefault() {
    emit((state));
  }
}
