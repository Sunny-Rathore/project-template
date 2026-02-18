import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String? name;
  final String? email;
  final String? avatarUrl;
  final UserRole? role;
  final DateTime? createdAt;

  const User({
    this.id,
    this.name,
    this.email,
    this.avatarUrl,
    this.role,
    this.createdAt,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
    UserRole? role,
    DateTime? createdAt,
  }) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    avatarUrl: avatarUrl ?? this.avatarUrl,
    role: role ?? this.role,
    createdAt: createdAt ?? this.createdAt,
  );

  @override
  List<Object?> get props => [id, name, email, avatarUrl, role, createdAt];
}

enum UserRole {
  admin,
  user,
  guest;

  static UserRole fromString(String raw) => UserRole.values.firstWhere(
    (r) => r.name.toLowerCase() == raw.toLowerCase(),
    orElse: () => UserRole.user,
  );
}
