// ─────────────────────────────────────────────────────────────────────────────
// APP CONSTANTS
// Swap BASE_URL at build time:  flutter run --dart-define=BASE_URL=https://...
// ─────────────────────────────────────────────────────────────────────────────

class ApiConstant {
  ApiConstant._();

  // ── Base URL ───────────────────────────────────────────────────────────────
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://pre-nirixir-version.ap-south-1.elasticbeanstalk.com',
  );

  // ── Endpoints ──────────────────────────────────────────────────────────────
  static const String usersEndpoint = '/users';
  static const String authLoginEndpoint = '/api/user/send_otp';
  static const String authLogoutEndpoint = '/auth/logout';
  static const String authRefreshEndpoint = '/auth/refresh';

  // ── Cache Keys ─────────────────────────────────────────────────────────────
  static const String usersListCacheKey = 'cache_users_list';
  static const String userDetailCacheKeyPrefix = 'cache_user_detail_';

  // ── Cache TTL ──────────────────────────────────────────────────────────────
  static const Duration cacheTtl = Duration(minutes: 10);

  // ── Pagination ─────────────────────────────────────────────────────────────
  static const int defaultPageSize = 20;
}
