// 🔹 Import all your screens
import 'package:task/core/app_export.dart';
import 'package:task/presentation/auth/cubit/auth_cubit.dart';

import '../main.dart';
import '../presentation/auth/view/login_screen.dart';

class AppRoutes {
  // 🔹 Route names (used for pushNamed)
  static const login = 'login';
  static const otpVerify = 'otpVerify';

  // 🔹 Paths (for URL & deep linking)
  static const loginPath = '/login';
  static const otpVerifyPath = '/verify-otp';

  // static const eventDetailPath = '/eventDetails/:id';

  // 🔹 Helper method for dynamic paths
  static String orderSummaryWithId(String id) => '/order-summary/$id';
  static String editProfileWithId(String id) => '/edit-profile/$id';

  // 🔹 GoRouter Configuration
  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: login,
    // initialLocation: PrefUtils.getIsNewUser()
    //     ? onboardingPath
    //     : (PrefUtils.getId().isNotEmpty && PrefUtils.getIsOnboarded())
    //     ? bottomBarPath
    //     : (PrefUtils.getId().isNotEmpty && !PrefUtils.getIsOnboarded())
    //     ? editProfilePath
    //     : loginPath,
    routes: [
      GoRoute(
        name: login,
        path: loginPath,
        builder: (_, sate) => BlocProvider(create: (_) => AuthCubit(), child: LoginScreen()),
      ),
    ],
  );
}
