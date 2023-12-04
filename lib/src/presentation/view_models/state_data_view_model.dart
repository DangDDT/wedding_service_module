// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/src/domain/enums/private/loading_enum.dart';

class StateDataVM<T> {
  StateDataVM(
    this.data, {
    this.message,
    this.status = LoadingState.initial,
  });

  final LoadingState status;
  final T? data;
  String? message;

  static none<E>(Type type) {
    switch (type) {
      case List:
        final List<E> list = [];
        return StateDataVM(list);
      case RxList:
        final RxList<E> list = RxList<E>.empty();
        return StateDataVM(list);
      default:
        return StateDataVM<E>(null);
    }
  }

  StateDataVM<T> _copyWith({
    ValueGetter<T?>? data,
    LoadingState? state,
    ValueGetter<String?>? message,
  }) {
    return StateDataVM<T>(
      data != null ? data() : this.data,
      message: message != null ? message() : this.message,
      status: state ?? this.status,
    );
  }

  ///Shortcut to create a [StateDataVM] with loading state with optional message
  ///
  ///from a old [StateDataVM]
  StateDataVM<T> loading({String? message}) {
    return _copyWith(
      message: () => message ?? this.message,
      state: LoadingState.loading,
    );
  }

  ///Shortcut to create a [StateDataVM] with success state
  StateDataVM<T> success(T data) {
    return _copyWith(
      data: () => data,
      message: null,
      state: LoadingState.success,
    );
  }

  ///Shortcut to create a [StateDataVM] with error state
  StateDataVM<T> error(String errorMessage) {
    return _copyWith(
      message: () => errorMessage,
      state: LoadingState.error,
    );
  }

  ///Shortcut to create a [StateDataVM] with empty state
  StateDataVM<T> empty() {
    return _copyWith(
      data: () => null,
      message: null,
      state: LoadingState.empty,
    );
  }

  bool get isInitial => status == LoadingState.initial;

  bool get isLoading => status == LoadingState.loading;

  bool get isSuccess => status == LoadingState.success;

  bool get isError => status == LoadingState.error;

  bool get isEmpty => status == LoadingState.empty;

  bool get hasError => message != null;

  @override
  bool operator ==(covariant StateDataVM<T> other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.data == data &&
        other.message == message;
  }

  @override
  int get hashCode => status.hashCode ^ data.hashCode ^ message.hashCode;

  Widget when({
    Widget Function()? initial,
    required Widget Function(String? message) loading,
    required Widget Function(T? data) success,
    required Widget Function(String? message) error,
  }) {
    if (isLoading) {
      return loading(message);
    } else if (isSuccess) {
      return success(data);
    } else if (isError) {
      return error(message);
    } else {
      return initial?.call() ?? const SizedBox.shrink();
    }
  }
}

extension StateDataVmRxX<T> on Rx<StateDataVM<T>> {
  bool get isInitial => value.isInitial;
  bool get isLoading => value.isLoading;
  bool get isSuccess => value.isSuccess;
  bool get isError => value.isError;
  bool get hasError => value.isError && value.message != null;
  bool get hasData =>
      value.data != null ||
      value.data != [] ||
      value.data != {} ||
      (value.data).toString().trim() != '';

  /// Check if the state is initial or loading and has no data
  bool get isInitialLoading => (value.isInitial || value.isLoading) && !hasData;

  void loading({String? message}) {
    value = value.loading(message: message);
  }

  void success(T data) {
    value = value.success(data);
  }

  void error(String errorMessage) {
    value = value.error(errorMessage);
  }
}
