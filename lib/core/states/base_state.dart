sealed class BaseState<T> {}

class InitilState<T> extends BaseState<T> {}

class LodingState<T> extends BaseState<T> {}
class Errorr<T> extends BaseState<T> {
 String? error;
 Errorr({this.error});

}
class Success<T> extends BaseState<T> {
  T? data;
  Success({this.data});

}
