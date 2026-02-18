import 'package:flutter/material.dart';
import 'package:task/core/di/configure.dart';
import 'package:task/presentation/cubit/theme_cubit.dart';

import 'core/app_export.dart';
import 'core/utils/logger.dart';
import 'domain/cubit/language_cubit.dart';
import 'l10n/app_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await PrefUtils.init();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    value,
  ) {
    runApp(MyApp());
  });

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    Logger.init(LogMode.debug);
    /*
    await NotificationService.initialize();
    await FirebaseMessagingService.initialize();
    await FirebaseMessagingService.handleInitialMessage();
    await FirebaseMessagingService.onBackgroundMessage();
    await FirebaseMessagingService.generateToken();
    */
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder:
          (
            BuildContext context,
            Orientation orientation,
            DeviceType deviceType,
          ) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (BuildContext context) => LanguageCubit()),
                BlocProvider(create: (BuildContext context) => ThemeCubit()),
              ],
              child: BlocBuilder<LanguageCubit, Locale>(
                builder: (BuildContext context, Locale locale) {
                  return BlocBuilder<ThemeCubit, ThemeMode>(
                    builder: (context, themeMode) {
                      return MaterialApp.router(
                        theme: AppTheme.lightTheme,
                        darkTheme: AppTheme.darkTheme,
                        themeMode: themeMode,
                        routerConfig: AppRoutes.router,
                        debugShowCheckedModeBanner: false,
                        locale: locale,
                        supportedLocales: const [
                          Locale('en'), // English
                          Locale('es'), // Spanish
                          Locale('fr'), // French
                        ],
                        localizationsDelegates: const [
                          AppLocalizations.delegate,
                          GlobalMaterialLocalizations.delegate,
                          GlobalWidgetsLocalizations.delegate,
                          GlobalCupertinoLocalizations.delegate,
                        ],
                        title: 'Task',
                      );
                    },
                  );
                },
              ),
            );
          },
    );
  }
}
