import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class UiState<T> extends Equatable {
  /// Methods for verifying state
  bool isLoading() => this is Progress;

  bool isLoading1() => this is Progress1;

  bool isError() => this is Error;

  bool isSuccess() => this is Success;

  /// This is nullable if we get data in other than Success state
  T? getData() {
    if (this is Success) {
      return (this as Success).data as T;
    }
    return null;
  }

  Object? getError() {
    if (this is Error) {
      return (this as Error).exception;
    }
    return null;
  }

  Widget build({
    Widget Function()? defaultState,
    Widget Function()? loading,
    Widget Function()? loading1,
    Widget Function(T data)? success,
    Widget Function(Exception exception)? error,
  }) {
    if (this is Progress) {
      return loading?.call() ?? const SizedBox.shrink();
    } else if (this is Progress1) {
      return loading1?.call() ?? const SizedBox.shrink();
    } else if (this is Success) {
      final T data = (this as Success).data;
      return success?.call(data) ?? const SizedBox.shrink();
    } else if (this is Error) {
      return error?.call((this as Error).exception) ?? const SizedBox.shrink();
    } else {
      return defaultState?.call() ?? const SizedBox.shrink();
    }
  }

  /// Just consumes the state but doesn't return any widget
  justConsume({
    Function()? onDefaultState,
    Function()? onLoading,
    Function()? onLoading1,
    Function(T data)? onSuccess,
    Function(Exception exception)? onError,
  }) {
    if (this is Progress) {
      onLoading?.call();
    } else if (this is Progress1) {
      onLoading1?.call();
    } else if (this is Success) {
      onSuccess?.call((this as Success).data);
    } else if (this is Error) {
      onError?.call((this as Error).exception);
    } else {
      onDefaultState?.call();
    }
  }

  List<Object> getProperties() {
    if (this is Success) {
      //success
      final success = this as Success;
      return [success.data];
    } else if (this is Error) {
      //error
      final error = this as Error;
      return [error.exception];
    } else {
      return [];
    }
  }

  @override
  List<Object> get props => getProperties();
}

/// These states represent the most common states in an application
// State representing loading
class Progress<T> extends UiState<T> {}

class Progress1<T> extends UiState<T> {}

// State representing content/success
class Success<T> extends UiState<T> {
  final T data;

  Success(this.data) : assert(data != null, 'data should not be null');
}

// State representing error
class Error<T> extends UiState<T> {
  final Exception exception;

  Error(this.exception);
}

// State representing default
class Default<T> extends UiState<T> {}
