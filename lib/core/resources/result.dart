abstract class Result<T> {
  final T? data;
  final String? error;
  const Result({this.data, this.error});

  void when({
    required Function(T data) success,
    Function(String e)? error,
  }) {
    if (this is Success<T>) {
      success((this as Success<T>).data as T);
    } else if (this is Failure<T>) {
      if (error != null) {
        error((this as Failure<T>).error!);
      }
    }
  }
}

class Success<T> extends Result<T> {
  const Success(T data) : super(data: data);
}

class Failure<T> extends Result<T> {
  const Failure(String e) : super(error: e);
}
