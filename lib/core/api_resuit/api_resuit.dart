 sealed class ApiResuit<T> {}
 class SuccessState<T> extends ApiResuit<T> {
  T? data;

  SuccessState({ this.data});
}
class ErrorState<T> extends ApiResuit<T> {
  String? errorMessage;
  ErrorState({this.errorMessage});
}