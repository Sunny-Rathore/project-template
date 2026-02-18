import 'package:task/core/utils/json_utils.dart';

import '../../domain/entities/user.dart';

class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? avatarUrl;
  final String? role;
  final String? createdAt;

  const UserModel({
    this.id,
    this.name,
    this.email,
    this.avatarUrl,
    this.role,
    this.createdAt,
  });

  // ── Deserialization ────────────────────────────────────────────────────────

  factory UserModel.fromJson(Map<String, dynamic> json) => safeParseJson(
    json,
    (j) => UserModel(
      id: j.isType<String>('id'),
      name: j.isType<String>('name'),
      email: j.isType<String>('email'),
      avatarUrl: j.isType<String>('avatar_url'),
      role: j.isType<String>('role'),
      createdAt: j.isType<String>('created_at'),
    ),
  );

  // ── Serialization ──────────────────────────────────────────────────────────

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'avatar_url': avatarUrl,
    'role': role,
    'created_at': createdAt,
  };

  // ── Entity mapping ─────────────────────────────────────────────────────────

  User toEntity() => User(
    id: id,
    name: name,
    email: email,
    avatarUrl: avatarUrl,
    role: UserRole.fromString(role ?? UserRole.user.name),
    createdAt: DateTime.parse(createdAt ?? DateTime.now().toString()),
  );

  static UserModel fromEntity(User u) => UserModel(
    id: u.id,
    name: u.name,
    email: u.email,
    avatarUrl: u.avatarUrl,
    role: u.role?.name,
    createdAt: u.createdAt?.toIso8601String(),
  );

  @override
  String toString() => 'UserModel(id: $id, name: $name)';
}

// ─────────────────────────────────────────────────────────────────────────────
// PAGINATED RESPONSE WRAPPER
// ─────────────────────────────────────────────────────────────────────────────

class PaginatedResponse<T> {
  final List<T> data;
  final int total;
  final int page;
  final int pageSize;
  final bool hasNextPage;

  const PaginatedResponse({
    required this.data,
    required this.total,
    required this.page,
    required this.pageSize,
    required this.hasNextPage,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) => safeParseJson(
    json,
    (j) => PaginatedResponse<T>(
      data: safeParseJsonList(j.isType<List>('data') ?? [], fromJson),
      total: j.isType<int>('total') ?? 1,
      page: j.isType<int>('page') ?? 1,
      pageSize: j.isType<int>('page_size') ?? 10,
      hasNextPage: j.isType<bool>('has_next_page') ?? false,
    ),
  );
}
