import 'package:dartz/dartz.dart';
import 'package:task/core/errors/failures.dart';

abstract class UseCase<T, P> {
  Future<Either<Failure, T>> call(P params);
}
