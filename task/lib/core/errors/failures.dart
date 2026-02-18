abstract class Failure {
  final String message;
  const Failure({required this.message});
  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message});
}

class UnknownFailure extends Failure {
  const UnknownFailure({required super.message});
}

class JsonParseFailure extends Failure {
  final dynamic debugInfo;

  const JsonParseFailure({required super.message, this.debugInfo});
}
