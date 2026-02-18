// 🔹 Import all your screens
import 'package:task/core/app_export.dart';
import 'package:task/core/di/configure.dart';
import 'package:task/presentation/cubit/auth/auth_cubit.dart';
import 'package:task/presentation/pages/login.dart';
import 'package:task/presentation/pages/user_list_page.dart';

import '../main.dart';

class AppRoutes {
  // Route names (used for pushNamed)
  static const login = 'login';
  static const userList = 'userList';

  //Paths (for URL & deep linking)
  static const loginPath = '/login';
  static const userListPath = '/user-list';

  //GoRouter Configuration
  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: loginPath,
    routes: [
      GoRoute(
        name: login,
        path: loginPath,
        builder: (_, sate) => BlocProvider(
          create: (context) => getIt<AuthCubit>(),
          child: LoginPage(),
        ),
      ),

      GoRoute(
        name: userList,
        path: userListPath,
        builder: (_, sate) => UserListPage(),
      ),
    ],
  );
}
