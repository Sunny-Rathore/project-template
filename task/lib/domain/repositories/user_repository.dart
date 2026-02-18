// lib/domain/repositories/user_repository.dart
// ─────────────────────────────────────────────────────────────────────────────
// USER REPOSITORY  — abstract contract (domain layer)
// Implemented by UserRepositoryImpl in the data layer.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:dartz/dartz.dart';
import 'package:task/core/errors/failures.dart';

import '../entities/user.dart';

abstract interface class UserRepository {
  Future<Either<Failure, List<User>>> getUsers({int page, int pageSize});
  Future<Either<Failure, User>> getUserById(String id);
  Future<Either<Failure, User>> createUser({
    required String name,
    required String email,
    required UserRole role,
  });
  Future<Either<Failure, User>> updateUser({
    required String id,
    String? name,
    String? email,
    UserRole? role,
  });
  Future<Either<Failure, void>> deleteUser(String id);
}
