import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import '../core.dart';

abstract class BaseBloc<E, S extends BaseState> extends Bloc<E, S>
    implements ErrorHandler<S> {
  BaseBloc(S initialState) : super(initialState);

  EventTransformer<E> eventTransformer() => sequential<E>();

  @override
  void handleError(
    Object error,
    StackTrace stackTrace,
    Emitter<BaseState> emit, {
    bool onlyLog = false,
  }) {
    AppLogger.logError(
      message: 'Error in BLoC $runtimeType',
      error: error,
      stackTrace: stackTrace,
    );

    if (!onlyLog) {
      emit(state.copyWith(
        status: BaseStatus.error,
        //baseError: getError(error),
      ));
    }
  }

// BaseError getError(Object error) {
//
//   // if (error is NoInternetConnection) {
//   //   return BaseError(ErrorType.noInternetConnection);
//   // } else if (error is Unauthorized) {
//   //   return BaseError(ErrorType.unauthorized);
//   // } else if (error is NotFound) {
//   //   return BaseError(ErrorType.notFound);
//   // } else if (error is ServerUnavailable || error is ServerTemporarilyUnavailable) {
//   //   return BaseError(ErrorType.serverUnavailable);
//   // } else if (error is TooManyRequests) {
//   //   return BaseError(ErrorType.tooManyRequests, message: error.retryAfter);
//   // } else if (error is NotAcceptable) {
//   //   return BaseError(ErrorType.notAcceptable, message: error.message);
//   // } else if (error is UnprocessableEntity) {
//   //   return BaseError(ErrorType.unprocessableEntity);
//   // } else {
//   //   return BaseError(ErrorType.unknown);
//   // }
// }
}

class BaseError {
  final ErrorType errorType;
  final String? message;

  BaseError(this.errorType, {this.message});
}

abstract class StateCopyWith {
  BaseState copyWith({
    required BaseStatus status,
    // BaseError? baseError
  });
}

abstract class ErrorHandler<S extends BaseState> {
  void handleError(Object error, StackTrace stackTrace, Emitter<S> emit);
}

abstract class BaseState implements StateCopyWith {
  final BaseStatus status;
  final BaseError? baseError;

  const BaseState({required this.status, this.baseError});

  bool get error => status.isError;

  bool get loading => status.isLoading;

  bool get success => status.isSuccess;

  bool get initial => status.isInitial;
}

enum ErrorType {
  noInternetConnection,
  unauthorized,
  notFound,
  serverUnavailable,
  tooManyRequests,
  badRequest,
  unprocessableEntity,
  notAcceptable,
  unknown,
}

extension BaseErrorExtension on BaseError? {
  bool get isNoInternetConnection =>
      this?.errorType == ErrorType.noInternetConnection;

  bool get isUnauthorized => this?.errorType == ErrorType.unauthorized;

  bool get isNotFound => this?.errorType == ErrorType.notFound;

  bool get isServerUnavailable =>
      this?.errorType == ErrorType.serverUnavailable;

  bool get isTooManyRequests => this?.errorType == ErrorType.tooManyRequests;

  bool get isBadRequest => this?.errorType == ErrorType.badRequest;

  bool get isUnprocessableEntity =>
      this?.errorType == ErrorType.unprocessableEntity;

  bool get isUnknown => this?.errorType == ErrorType.unknown;
}

enum BaseStatus { initial, loading, error, success }

extension BaseStatusExtension on BaseStatus {
  bool get isSuccess => this == BaseStatus.success;

  bool get isLoading => this == BaseStatus.loading;

  bool get isInitial => this == BaseStatus.initial;

  bool get isError => this == BaseStatus.error;
}
