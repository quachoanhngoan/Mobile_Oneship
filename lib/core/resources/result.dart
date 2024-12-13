abstract class Result<T> {
  final T? data;
  final String? failure;
  const Result({this.data, this.failure});

  void when({
    required Function(T data) success,
    Function(String e)? failure,
  }) {
    if (this is Success<T>) {
      success((this as Success<T>).data as T);
    } else if (this is Failure<T>) {
      if (failure != null) {
        failure((this as Failure<T>).failure!);
      }
    }
  }
}

class Success<T> extends Result<T> {
  const Success(T data) : super(data: data);
}

class Failure<T> extends Result<T> {
  const Failure(String e) : super(failure: e);
}
