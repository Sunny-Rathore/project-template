// import 'exceptions.dart';
// import 'failures.dart';

import 'package:task/core/errors/exceptions.dart';
import 'package:task/core/errors/failures.dart';

class FailureMapper {
  FailureMapper._();

  static Failure fromException(AppException error) {
    return switch (error) {
      final ServerException e => ServerFailure(message: e.message),
      final NetworkException e => NetworkFailure(message: e.message),
      final JsonParseException e => JsonParseFailure(message: e.message),
      final CacheException e => CacheFailure(message: e.message),
      final NoInternetException e => NetworkFailure(message: e.message),
      _ => UnknownFailure(message: error.message),
    };
  }

  static Failure fromError(Object error) {
    if (error is AppException) return fromException(error);

    return UnknownFailure(message: error.toString());
  }
}
