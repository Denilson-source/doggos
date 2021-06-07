import 'package:get/get.dart';

class ControllerState<T> {
  T? error;

  final _rxState = State.initial.obs;
  State get state => _rxState.value;
  set state(State value) => _rxState.value = value;

  ControllerState.initial() {
    state = State.initial;
  }

  ControllerState.isLoading() {
    state = State.isLoading;
  }

  ControllerState.hasData() {
    state = State.hasData;
  }

  ControllerState.hasError(this.error) {
    state = State.hasError;
  }

  bool get initial => state == State.initial;
  bool get isLoading => state == State.isLoading;
  bool get hasData => state == State.hasData;
  bool get hasError => state == State.hasError;

  void setInitial() => state = State.initial;
  void setIsLoading() => state = State.isLoading;
  void setHasData() => state = State.hasData;
  void setHasError(T error) {
    state = State.hasError;
    this.error = error;
  }
}

enum State { initial, isLoading, hasData, hasError }
